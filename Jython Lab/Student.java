import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

public class Student {
	String name, birthDate;
	double marks, outOf, grade, age;
	
	public Student() {
		
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public void setMarks(double marks) {
		this.marks = marks;
	}
	
	public void setOutOf(double outOf) {
		this.outOf = outOf;
	}
	
	public double calculateGrade() {
		this.grade = round((marks / outOf) * 100, 2);
		return grade;		
	}
	
	public static double round(double value, int places) {
		if (places < 0) throw new IllegalArgumentException();
		
		BigDecimal bd = new BigDecimal(value);
		bd = bd.setScale(places, RoundingMode.HALF_UP);
		return bd.doubleValue();
	}

	public double calculateAge() {
		String month, day, year;
		StringTokenizer stok = new StringTokenizer(this.birthDate, "-");
		month = stok.nextToken();
		day = stok.nextToken();
		year = stok.nextToken();
		
		
		Calendar birthday = Calendar.getInstance();
		birthday.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
		return getAge(birthday.getTime());
	}
	
	public double getAge(Date dateOfBirth) {
		Calendar today = Calendar.getInstance();
		Calendar birthDate = Calendar.getInstance();
		birthDate.setTime(dateOfBirth);
		if(birthDate.after(today)) {
			throw new IllegalArgumentException("You do not exist yet");
		}
		int todayYear = today.get(Calendar.YEAR);
	    int birthDateYear = birthDate.get(Calendar.YEAR);
	    int todayDayOfYear = today.get(Calendar.DAY_OF_YEAR);
	    int birthDateDayOfYear = birthDate.get(Calendar.DAY_OF_YEAR);
	    int todayMonth = today.get(Calendar.MONTH);
	    int birthDateMonth = birthDate.get(Calendar.MONTH);
	    int todayDayOfMonth = today.get(Calendar.DAY_OF_MONTH);
	    int birthDateDayOfMonth = birthDate.get(Calendar.DAY_OF_MONTH);
	    age = todayYear - birthDateYear;
	    
	    if ((birthDateMonth == todayMonth) && (birthDateDayOfMonth > todayDayOfMonth)){
	        age--;
	    }
		return age;
	}
	
	public String displayDetails() {
		return name + "\nAge: " + (int)age + "\nDOB: " + birthDate + "\nGrade: " + grade + "%";
	}
}
