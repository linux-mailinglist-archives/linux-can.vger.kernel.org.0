Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F6672282
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 17:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjARQHe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjARQG6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 11:06:58 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2088.outbound.protection.outlook.com [40.107.135.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A55420F
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 08:03:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/l2YD2G/P3PQOhGaC+fu33GWLAWBP+0ZR/jWoTwk3ek2Alnj23OrKOEqc/1bKkkmkfd8BkjAm6Zv6CZB0aICnaTfq5lfv4CjBywrYWq8PAZtmXAdYQ8ycbMxFQnKI/14TCxt2gzHh38J5tExnRGQooCyH6fBhEAvXSUZg+za384ih7hxUqTQqi6lEerhFviBzUyl1Xb3bUbTRN9Ch1VNh5s4IkfAcobJciugAD/arbgxLO0NwrffqhupVn4Pah0VL0gFuGfR2C+bQPwn5zYZV3XV7xI7DAgHbi5fhua2JwExTEmnvoOQo3ZrgkznmJIUENa/z+ulRqrZEQbGsE++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl+yOfAtX4wKvr8LIkpSx7l15xbJArqd3hRvYFv6AfI=;
 b=HTP2LFcmfGguhjIIxkMSDV1GM+n14e6bx0Rjc8OcS4LGFJTi7mVCcaIOw2ywndFiANVQAqei8kaUkM2xsGAqpUOHIKV+sXzqjJaO/BYxYF/+TlJGAgR8E5W/nBX2n6Mm0oDmjGKz5+O/zceT1emPNmgdJhnOFwjE+AmsVnQnjSe9xhEXLhX1uUZHYvdDIfF20H+xwcRYegCrlMxBzv8+ncWxWUVC7lJxCflJO+ekxmuZCoQc//Vo8x9Xr9vIRNfVw/xVNAbIRf/wJ5SVVfjx7iDYHLS4Y9cxdlV8e/5YiXO4j7MyERABEEnyzeJQQyfSF2CzGC0Q+GIHzgRCjpAZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl+yOfAtX4wKvr8LIkpSx7l15xbJArqd3hRvYFv6AfI=;
 b=xlYZaat7oyOu6LAZWU92zcowC0kPsQKPT3ype+dyAjaolR539kvM1lsM4ML6Cd1Iu88TjUKAHfYJiRc0SJZwFvG9O5VUtSX5A4DsEJ44kTFHFII0LUGzNWs6MJmPOzV2vg3yWxmBe7d/QKKinhCM/LP2ZzdFpcaQpDyLggkqaGk=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by BEZP281MB2966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 16:03:43 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 16:03:43 +0000
From:   =?iso-8859-1?Q?Stefan_Alth=F6fer?= <Stefan.Althoefer@janztec.com>
To:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKzjliniR2Rjet0qunKK2mAziB66kQAkAgAATQtA=
Date:   Wed, 18 Jan 2023 16:03:43 +0000
Message-ID: <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|BEZP281MB2966:EE_
x-ms-office365-filtering-correlation-id: a2c582c4-b0ee-44df-c237-08daf96d9295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFvujHDqdcRSnze+LSkO46yHIIenh8tm1pVch6D2cYIX/zv8c/h1SWQjmBUSYBtYL+yaHUl5875Z4ooKTIGl00hCEKxg+rzBYueeNRzk6RmRiFIyf+cLwaqucuKKCqqu66/Xa6Va1WIqA2oTYfWUwlsKRbeC5+mHb71Me8j4vz1NWas4E0HP47CMLLBVqq/P9o2kpXt9LHeAmttIZcPDJjXn5xuYnCkVXG01+R1C2caG0M+LMjuw5lUFSH5wZDZQVeG4/73vcOyV+nMF3SBcU94voVFUHCkXXg71omkt5Jz9k6DhpCqSPi4o4PP/Kv8y0ocumYDT7AYtvYHhv1WxHQCM8FxwqahRk6DQkE2pbUmIMFeLSV4NBqIkZIYKntAHJ7GT9nr+qhAqx3am2PHzurxafWALk0la4kwLEqFGvzHiNHcJ1cytXT+9Tg/9JZk+wBsI9I9Hgl1SKpM4cBw/JQ7mGx6ENQIBV0yGGBad+m50yHRYfQPwiWfsL1OEmPq53Qr4XrwG7pkdDmF9d2REzJLgr9jRKWjIdUI4p2MU5rBT39tc3KUhekL74VeJqX2EyjorWf5T4Iz/LM1KiCFLkTMP1PMUziXQRDMwBENTWWtOzu12sWOfHm/oQL7pvjYSBYmHUWlGin5/WfOQhhG7Jk5g6/kiv2WlYZwrfMtfkxMSRggcj0lJwR8yFNYY40Rva1imKVjmRUy8J4DJfpV05A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39840400004)(346002)(366004)(136003)(396003)(451199015)(55016003)(33656002)(41300700001)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(5660300002)(76116006)(83380400001)(52536014)(9686003)(478600001)(186003)(26005)(8936002)(6506007)(110136005)(316002)(71200400001)(7696005)(38070700005)(86362001)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3DNGoPlVL6rdEQnIMU+QCL6bGJXd/NoDSnVSeHULsgQDe1+xgLoD1KrWs?=
 =?iso-8859-1?Q?YnDuqnJShp9ZBmHlitdzy3hVtrC5wj8zPf5DFZ7gRDY7mGYj9HHYfMLhen?=
 =?iso-8859-1?Q?kjBiQt054QhJJpQjEbE114WjATvBNHfVA5EMqK9zo//d2a5BzE+BqJsisr?=
 =?iso-8859-1?Q?L6555kuX9FNUVUWo16Br3zANN3Pcv8oONPwlX4s9eQbybTPnrxk7FP/UFS?=
 =?iso-8859-1?Q?T2ltltxl8D5UO089JOm3+O29HpGtEBgNhxvjNV5zhFRY5/dip5gAmAgxPz?=
 =?iso-8859-1?Q?QgpslPdc+18LEeIv9hKdtQ0yEexWeUo8CiFYRwRYawOzOwsS8zomI7v47k?=
 =?iso-8859-1?Q?W2blAoWCQFB2ZkHetkrp7KL3ARidno4hSJwUXh4Rkg5z+tEu6IJLt4alXv?=
 =?iso-8859-1?Q?BpO+C3tySdIwU7YDvfkshWd3CDNfoIPQgqR401gNJep+t9DvLWqvzQL6y9?=
 =?iso-8859-1?Q?uLcrfvf1+G0PExztavk+8itKGCRHMgSF4zJe9fnXvA9bHrMCDQn/d/mEs5?=
 =?iso-8859-1?Q?uWE0YNhPz6LQ2In0SOTlYMmqV60TUtSFqmmn2TlaOIVZJjhod0FI03Fk0C?=
 =?iso-8859-1?Q?kCV9sAI9nebFSd8yVviRJjlw4VDnVow+nt907xPXUxgcKmmkcsEUG6vfAl?=
 =?iso-8859-1?Q?nsv1HF6BVnwFdckFvJNh+s61M/KyfVGBBL9Uox0Nf4ro9VeuMS//bTv7SS?=
 =?iso-8859-1?Q?nvFT9G2UoxoX02y5cZ/KQrJW03LwwcmQ7q1sw2qWcW5e399wAdYkj6rHko?=
 =?iso-8859-1?Q?FNfTYtTBrkfoeDdc4+KRbJG7wJIgvCmD4ymb2/r+tOZtMcLxbAhB0ekHgv?=
 =?iso-8859-1?Q?y6ChgUzW0AhHXI6+ZeTnHQN5acyQyMaOln+0DcJCGJ1SYM2TEiJGXeLf5Q?=
 =?iso-8859-1?Q?KXSJ4trp0xoH+vRtG7RDwVvwB5EYKySkZvt/ROLPa38X3/OLPkhESgQMgj?=
 =?iso-8859-1?Q?lBnw+7/9rF2Lf8pmNJJ0eE5q0pMXluRxATExs7hrq1ktYCGh+lQgkdTmQ3?=
 =?iso-8859-1?Q?klx5XFESMOZ/w7gayZLCDoJT7la64iO5WDnoJvNs/JFFqp3GFiebPZT3iV?=
 =?iso-8859-1?Q?O+nDu/HDm9ashrW1tErdXlvd34NopMOWS3wDkssmyEwAdrP+qj2hybY3FY?=
 =?iso-8859-1?Q?kwU4F+oIA6MZHLLLuPryn6763J/p/Ef3ydNkGNIlKUhJx4+3dZ0zDdg+x5?=
 =?iso-8859-1?Q?Unje5NYLPjrcD75IJEra88lvUP77FmLwjPKB1esmXMSXW88Ubi3DxoDqoI?=
 =?iso-8859-1?Q?poAQpNWmAl5kSybrgnoP9aJDlqgxPdfwNNcBAKxXlug3Cb6tjfL0e0Fnwl?=
 =?iso-8859-1?Q?7krwi/V73gpUwyivYnj7T4/KZgrmrvq7q4akc0tD+KK0thyp9Jr2k5EgRk?=
 =?iso-8859-1?Q?qYJk7f2JNm5Ph93Bv7MExTu4yZit2jQCbIcNp9dt6DO8dtvFaAoXOrURm/?=
 =?iso-8859-1?Q?Fm7TU2F0FhkXZuiA4S3KbZa8ct/niD2jf6vWX1G0QwpTLc8H2XPsqC4ZqS?=
 =?iso-8859-1?Q?qsaAsikrlqKhn411BErGuJx7RuoHSsvYBO7XY471F38poqj5y1sIpO+Zzm?=
 =?iso-8859-1?Q?wHSYOa1E59Rfb57LhRwtE2FxXJ/u95kRu98ge4IndhIInVoZ2md/CygAon?=
 =?iso-8859-1?Q?UW0rpNzR6v5U/uYcr2XnMEvKXKzgegaSweYNsXlUFKyMwtjFk1H2nOWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c582c4-b0ee-44df-c237-08daf96d9295
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 16:03:43.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMBhVh9Xj7ShW/X7JIBJlG9fhJyI3xvVWQ2LJYEIDI/UB6QJEWi7D3Ri6FMRA1JgYBONQWsZZ7AmKnzDU8DoQ5sOb+/GddyGLActgSawYPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2966
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> How often does this happen for you?
> What's your SPI speed? Do you see the errors on SPI0 and SPI6 or only one=
 of them?

One failure was after 1h30, the other after 5h

Seems the transmit fifo messages appear on both:

Jan 18 04:09:32 raspberrypi kernel: [400402.605220] mcp251xfd spi0.0 can0: =
Transmit Event FIFO buffer not empty. (seq=3D0x0000016c, tef_tail=3D0x00000=
170, tef_head=3D0x00000171, tx_head=3D0x00000171).
Jan 18 04:31:19 raspberrypi kernel: [401710.169610] mcp251xfd spi6.0 can1: =
Transmit Event FIFO buffer not empty. (seq=3D0x00001d26, tef_tail=3D0x00001=
d2a, tef_head=3D0x00001d2b, tx_head=3D0x00001d2b).
Jan 18 04:54:48 raspberrypi kernel: [403118.964603] mcp251xfd spi0.0 can0: =
Transmit Event FIFO buffer not empty. (seq=3D0x00000900, tef_tail=3D0x00000=
904, tef_head=3D0x00000905, tx_head=3D0x00000905).
Jan 18 05:03:31 raspberrypi kernel: [403641.894620] mcp251xfd spi6.0 can1: =
CRC read error at address 0x0010 (length=3D4, data=3D04 4b 01 00, CRC=3D0xb=
14c) retrying.
Jan 18 05:08:32 raspberrypi kernel: [403942.287189] mcp251xfd spi6.0 can1: =
Transmit Event FIFO buffer not empty. (seq=3D0x000008fe, tef_tail=3D0x00000=
902, tef_head=3D0x00000903, tx_head=3D0x00000903).
Jan 18 05:16:20 raspberrypi kernel: [404410.525137] mcp251xfd spi6.0 can1: =
Transmit Event FIFO buffer not empty. (seq=3D0x000012aa, tef_tail=3D0x00001=
2ae, tef_head=3D0x000012af, tx_head=3D0x000012b0).
Jan 18 05:27:41 raspberrypi kernel: [405091.805650] mcp251xfd spi6.0 can1: =
Transmit Event FIFO buffer not empty. (seq=3D0x00000152, tef_tail=3D0x00000=
156, tef_head=3D0x00000157, tx_head=3D0x00000157).
Jan 18 05:34:00 raspberrypi kernel: [405471.116322] mcp251xfd spi0.0 can0: =
Transmit Event FIFO buffer not empty. (seq=3D0x00001e36, tef_tail=3D0x00001=
e3a, tef_head=3D0x00001e3b, tx_head=3D0x00001e3b).

spi6 (can1): 10 MHz
spi0 (can0): 16,67 MHz (admitted, this was not intended)

Funny: the truncated message was received on can1 - with lower speed. And I=
 have never seen other CRC errors than for address 0x0000 and 0x0010.

--
Stefan



