[[c++]] #cpp
когда запрашиваем поамять через `new()` нам может выбросить исключение и аварийно завершить программу(в случае обращаение к несуществующему адресу или переполнения памяти), в таком случае используем `new(nothrow)`, который в случае ошибки вернет `nullptr`

Оператор : : называется оператором разреш ения области видимости
(*scope resolution operator*). Например, синтаксис Hum an `::dateOfBirth`
относится к переменной `dateOfBirth`, объявленной в пределах класса
Human. Синтаксис `::dateOfBirth` же относится к другой переменной
`dateOfBirth`, объявленной в глобальной области видимости.

⚠️ Почему `static_cast<void*>`?  
Потому что `std::cout` по умолчанию считает `char*` как C-style строку, и будет пытаться печатать содержимое до `'\0'`.  
Чтобы этого избежать — приводим к `void*`, чтобы он вывел именно адрес.

-v /tmp/.X11-unix:/tmp/.X11-unix \

docker run -it --name astralinux-test-4 \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    tmp_image:latest \
    bash




```cpp
void NewWaterObjectDialog::setupValidators()
{
    // Скорость
    m_ui->lineEditVelocitySingle->setValidator(new MyDoubleValidator(0, 50.00, 2, this));
    m_ui->lineEditVelocityMulti->setValidator(new MyDoubleValidator(0, 50.00, 2, this));


    // СКО определения скорости
    m_ui->lineEditSKO_velocitySingle->setValidator(new MyDoubleValidator(0, 10.00, 2, this));
    m_ui->lineEditSKO_velocitySingle->setToolTip(TOOLTIP_SPEED);
    m_ui->lineEditSKO_velocityMulti->setValidator(new MyDoubleValidator(0, 10.00, 2, this));
    m_ui->lineEditSKO_velocityMulti->setToolTip(TOOLTIP_SPEED);

    // Дальность
    auto DValidator = new QIntValidator(15, 99999, this);
    m_ui->lineEditDSingle->setValidator(DValidator);
    m_ui->lineEditDMulti->setValidator(DValidator);

    // СКО определения дальности
    auto SKO_dValidator = new QIntValidator(0, 20, this);
    m_ui->lineEditSKO_dSingle->setValidator(SKO_dValidator);
    m_ui->lineEditSKO_dMulti->setValidator(SKO_dValidator);

    // Номер отметки
    auto vInt9 = new QIntValidator(0, 999999999, this);
    m_ui->lineEditNMulti->setValidator(vInt9);
    m_ui->lineEditNSingle->setValidator(vInt9);

    // СКО определения пелинга
    m_ui->lineEditSKO_pelengMulti->setValidator(new MyDoubleValidator(0.0, 20.000000,6, m_ui->lineEditSKO_pelengMulti));
    m_ui->lineEditSKO_pelengSingle->setValidator(new MyDoubleValidator(0.0, 20.000000,6, m_ui->lineEditSKO_pelengSingle));

    m_ui->lineEditPelengMulti->setInputMask(AZIMUTH_INPUT_MASK);
    m_ui->lineEditSKO_pelengMulti->setInputMask(AZIMUTH_INPUT_MASK);

    // Курс цели
    m_ui->lineEditCourseSingle->setInputMask("0.000000° 000.000000°;_");
    m_ui->lineEditCourseMulti->setInputMask("0.000000° 000.000000°;_");
    m_ui->lineEditCourseSingle->setValidator(new MyDoubleValidator(0.0, 359.999999,6,m_ui->lineEditCourseSingle));
    m_ui->lineEditCourseMulti->setValidator(new MyDoubleValidator(0.0, 359.999999,6,m_ui->lineEditCourseMulti));

    // СКО определения курса
//    m_ui->lineEditCourseSingle->setInputMask("00.000000° 00.000000°;_");
//    m_ui->lineEditCourseMulti->setInputMask("00.000000° 00.000000°;_");
    m_ui->lineEditSKO_courseSingle->setValidator(new MyDoubleValidator(0.0, 25.000000,6,m_ui->lineEditSKO_courseSingle));
    m_ui->lineEditSKO_courseMulti->setValidator(new MyDoubleValidator(0.0, 25.000000,6,m_ui->lineEditSKO_courseMulti));

    // Минимальная дальность
    m_ui->lineEditDminSingle->setValidator(new QIntValidator(10, 1500,this)); m_ui->lineEditDminSingle->setMaximum(1500);
    m_ui->lineEditDminMulti->setValidator(new QIntValidator(10, 1500,this)); m_ui->lineEditDminMulti->setMaximum(1500);

    // Максимальная дальность
    m_ui->lineEditDmaxSingle->setValidator(new QIntValidator(10, 1500,this)); m_ui->lineEditDmaxSingle->setMaximum(1500);
    m_ui->lineEditDmaxMulti->setValidator(new QIntValidator(10, 1500,this)); m_ui->lineEditDmaxMulti->setMaximum(1500);

    // Радиус ядра
    m_ui->lineEdit_coreMulti->setValidator(new MyDoubleValidator(0.3, 120.0, 1, m_ui->lineEdit_coreMulti));

//    auto styleSheetCore = m_ui->lineEdit_coreMulti->styleSheet();
//    connect(m_ui->lineEdit_coreMulti, &QLineEdit::textChanged, [=]() {
//        bool isValid = m_ui->lineEdit_coreMulti->text().toDouble() >= 0.3 && m_ui->lineEdit_coreMulti->text().toDouble() <= 120.0;
//        if (!isValid) {

//            m_ui->lineEdit_coreMulti->setStyleSheet("border: 1px solid red;");  // Выделить красным, если значение неверное
//        } else {
//            m_ui->lineEdit_coreMulti->setStyleSheet(styleSheetCore);  // Восстановить стиль, если значение правильное
//        }
//    });

    // Радиус я.ордера
     m_ui->lineEditRadiusMulti->setToolTip(TOOLTIP_NUM);
     m_ui->lineEditRadiusMulti->setValidator(new MyDoubleValidator(0.3, 0.3, 1, m_ui->lineEditRadiusMulti));

     // СКО определения географических координат цели
     //m_ui->lineEditSKO_positionSingle->setToolTip(TOOLTIP_NUM);
     m_ui->lineEditSKO_positionSingle->setValidator(new QIntValidator(0, 20, this));
}
```



```cpp
if(m_ui->lineEditDminMulti->text() < 15000) {m_ui->lineEditDminMulti->setPalette(pLineEditError);}
                        else m_ui->lineEditDminMulti->setPalette(pLineEditNormal);
```



```cpp
QIntValidator* tmpValidator = qobject_cast<QIntValidator*>(m_ui->lineEditDMulti->validator());

            if (m_ui->lineEditDMulti->text().toInt() < tmpValidator->bottom()) { m_ui->lineEditDMulti->setPalette(pLineEditError);}

                else m_ui->lineEditDMulti->setPalette(pLineEditNormal);
```



```bash
 docker run -it --name astralinux1.8 \                                    
    -v /home/boss/forpost:/home/brav/forpost2 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    epicmorg/astralinux:1.8-main \
    bash
```



```bash
docker run -it --name ubuntu_wayland_test3 \
  --device /dev/dri --group-add video \
  -e WAYLAND_DISPLAY=wayland-1 \
  -e XDG_RUNTIME_DIR=/run/user/1000 \
  -v /run/user/1000:/run/user/1000 \
  --user 1000:1000 \
  ubuntu_with_all:latest

```


