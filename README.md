# Plane-Notify-Redux

An updated version of [Plane-Notify](https://github.com/Jxck-S/plane-notify)

## Description

[Jxck-S](https://github.com/Jxck-S) created Plane-Notify several years ago and while it had a great run, I believe he got very busy with other projects and was unable to dedicate more time to this. I really liked the idea of being notified when my favorite planes took off and I wanted to find a way to update this so that others could also enjoy their favorite planes taking off too! 

FOR THE RECORD - I AM NOT A CODER. This has been frankensteined through countless Google searches and with the help of AI. I just wanted to set the record straight on that!

Some of the changes that I've made are:
### General Fixes
* Fixed configparser.MissingSectionHeaderError by removing BOM from .ini files.
* Ensured self.last_pos_datetime is always timezone-aware to avoid datetime errors.
* Handled NoneType issues when accessing self.last_pos_datetime.tzinfo.
* Fixed TypeError: can't subtract offset-naive and offset-aware datetimes.
* Corrected plane tracking logic to ensure timestamps are properly managed.
* Added a PowerShell script that generates plane specific ini files from inputted ICAOs
### Discord Integration Enhancements
* Added support for posting to Discord threads via webhooks.
* Modified sendDis() to append thread_id to webhook URLs.
* Ensured Discord role mentions (role_id) remain functional.
* Updated Discord .ini configuration to include THREAD_ID field.
* Fixed incorrect sendDis() function calls in planeClass.py.
* Ensured images attach properly when posting to Discord.
### Selenium & Screenshot Fixes
* Increased page load timeout to prevent TimeoutException errors in Selenium.
* Optimized Chrome options for stability in headless mode.
* Prevented Chrome crashes by adding --disable-gpu and --no-sandbox flags.
* Handled WebDriver issues with correct ChromeDriverManager().install() setup.

## Getting Started

### OS

Ubuntu 24.04 LTS

### Dependencies

* Python3

### Installing

* Clone this repository
  ```
  sudo git clone 
  ```
* Clone OpenSky repository into plane-notify-redux directory
  ```
    git clone https://github.com/openskynetwork/opensky-api.git
  ```
* Install Python3 and Pip
  ```
  sudo apt install -y python3 python3-pip pipenv pkg-config libcairo2-dev libjpeg-dev libpng-dev
  pipenv run pip install -r requirements.txt
  ```

### Executing program

```
pipenv run python __main__.py
```

## Version History

* 0.1
    * Initial Release

## Acknowledgments

I'd first like to acknowledge the heck-of-a-job Jack Sweeny did to get this thing created! If it weren't for his work, I would not have been able to share this. 
