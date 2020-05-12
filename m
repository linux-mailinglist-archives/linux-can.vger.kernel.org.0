Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66BF1CEE9E
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2020 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgELH4x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 May 2020 03:56:53 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:61250
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgELH4w (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 May 2020 03:56:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNy+i+q3JOYlFeR8DZCoJ/1/2Mu5CEgBJVWc8yMpAxk8UAVyjrnNcavjmkvR/ddhls6J4LYDkxT4FlJdBV5qqPX/OnlcHcX8xVC8vDzNGSMLW8t7Lmj8KlsvjESdxSd/LmQPYzEadw7097+t5jMRHqfS/txpdBujkrf64YoUbG7V1aHrAuolFen3tCt+oQY9AMIkEe94Rg94L9J25gpjInVocLiOsK2YNlIm8ny2IHHuP6yVjjlqy1PPs7uTg/aAM5sKFGAVkAgbY4ZNjamWB9snrI5oQsUhqcC2S6/L0cbvnXl0nIH+C/+rCHqT7dKhSAozWnaZz65uUBmx7dLy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABpNvhsmm9NiOOcDPMdKPrr9l8cqaSAKo9Kmlkn6BQM=;
 b=CQC5PCMvan/ZfOOAb2bM9BHwEmsO3o004uEtjZAVHOCbN0J+KNfxTVgzsB074TFrX791VuI09j7kiw0oQNj4Mo6ijjRfxX43BK63ploDCqV9tl/qzhvNbav9GqWtAJQQnbf+U4eM/k8EwEXA5Qpd3+pfJ5X2TMRN2aGa2XWY3/3DL4Tv5x5pblQbcR2FSWk6fJjUzpZLgnoB7O3030Dx/FWqOViQqwZXjqzz/MZvbBbsgjDTd8kZnPUejZGd9NP0CyymDsWRgOtoGMK5Q224F0Aij7uGNemdjsWWHUwFbyWjUx4X7rDXFP+tWtbHK+X+shSmjktX+BT+9wFTaVjusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABpNvhsmm9NiOOcDPMdKPrr9l8cqaSAKo9Kmlkn6BQM=;
 b=OEHdkLdJhtfyEaN+S11vLFhCXKA7JOm8ZcuhSkgL+C69pctdrzs7TBeZHdu1N8+en/06CeCKy2hhfPCfPUmcV4q1Di7Wcvbub5mcuM2nILhDN3h5jfrdR0Ko+ny+hDcOtpXHXZrfCf8KNVBGz69wqhk0RTo/UBGqev4e6ZAyjXI=
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com (2603:10a6:6:37::10) by
 DB6PR03MB3127.eurprd03.prod.outlook.com (2603:10a6:6:34::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Tue, 12 May 2020 07:56:47 +0000
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::31fd:a916:e3c8:ab96]) by DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::31fd:a916:e3c8:ab96%2]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 07:56:47 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     =?iso-8859-1?Q?Fabi=E1n_Inostroza?= <fabian.inostroza.p@gmail.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: PCAN USB hardware timestamps jumps forward
Thread-Topic: PCAN USB hardware timestamps jumps forward
Thread-Index: AQHWJjTrtWd/3ZhRMk2RuZQ3CRhDRKikF0iV
Date:   Tue, 12 May 2020 07:56:47 +0000
Message-ID: <DB6PR03MB3093457A77199F550EBBA84CD6BE0@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <CAArkK-dJkWCfUoTfZeXDiKSKNeey6_CwAK_gNB5QoRs=kA2O5A@mail.gmail.com>
In-Reply-To: <CAArkK-dJkWCfUoTfZeXDiKSKNeey6_CwAK_gNB5QoRs=kA2O5A@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=peak-system.com;
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7ceb50-3b51-43b2-999b-08d7f64a0576
x-ms-traffictypediagnostic: DB6PR03MB3127:
x-microsoft-antispam-prvs: <DB6PR03MB312721022221ED90F0FBEF76D6BE0@DB6PR03MB3127.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dP8rJjTAJ9pvcPQzoHsB3PhJ6UY/gskYY7dkmRkjoqM9nd2qsDvMuFQx0tLW4b9MjrJQseXxe36Zkli0twO2fkPgpghF0K8F3/xq0zc8so1AxhsVh5llNtllbbrEapFAGjbhYN5DR2aA/lxRaDuVTuDwNCmF+60w+VdmVh5JnCo60PvWBAooPSMzD4uRk+HK4Nj3CLka1AnI5RxPYCjxSptXxW/R0ea0VFVwI5Q7pZfWlfQbE+aDjr1MqD47S8JZv5VH6wAMtr/IW1yW1zIYYPvo115/Gf0tndobMHk84KSAQyMwEjDRLTSiA6cW/QGVfxXWcgIV+xrebO2A4POsMochEooHpXZsYUzFjtmR0J38ny8TbiH4IRR/IDp/+2Wj2xLIAWO/qROV08YsQHMytedZx5j8hb6Zn8UyA5lIRwnt6jQ1fvpumVXR42KZ7Iw0CqgEaiPdXYPCDX8jkiz4hxEo4hVUyyfru3TAtMQ3vqlQ4VzJ7kL+0EeLwJeee4Gd4Oo1UpuM5yj37r26Bkk9Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3093.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39840400004)(376002)(396003)(346002)(366004)(33430700001)(4326008)(71200400001)(55016002)(64756008)(86362001)(15974865002)(33656002)(2906002)(7696005)(33440700001)(26005)(66946007)(186003)(66446008)(66556008)(66574014)(76116006)(66476007)(508600001)(8936002)(5660300002)(53546011)(6916009)(316002)(52536014)(9686003)(6506007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4ILZiGICaOx98jPFacsvFjly0eA/qbfw3opl9P/C2bpmWzLS04n250N9qLNWrz8KoCktqmhVE7CrRM2t2X8lXZmLkJfZwpxPCO2l5kMKiORO4zenjA1oquZ2fU/IBYFo+qANRe2B86mY3zFlYNCKmNJ39PZ5hMCaiURo6qVBXz4CE6aD3MsikIbrz0/OPAj9ssxlnBmMT6nV/f2STMf5ijMmVPBVNA5RrQfYQG2X2mRVaPScr6yDkPRdZzZkDPlP6gBw+BftK8E/BhcXRFoaQBes2vf7llilI71hnM3v3pUzQw7bDdYDjl0dsZMaAW0E3EVEbUXUPvhD5dVuxOA+HYRy5NdiIPnvPV7O/KF8gX3VraKUS/gYEL+rK1Y1zNCSgRtWpm99jKAmybJpD1+j2tm5MQQmvOPbq+R57LAeLjQhYtzoKZZrt3vvWJhVnnqqjB+wXL8i1AKXqrO/sVkSP/jxtNzW1FPvNrZkxNVVx+OQF5hpSVaoHY+zVEhcKLZj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7ceb50-3b51-43b2-999b-08d7f64a0576
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 07:56:47.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/ljwQDzRrxmXSJC+pejlDhFF6xNjdQuywwqKTjJa1mjSWrsWouucTbJzfvaHuj4OdX+dAyoTfb+tnYEfobz1G7CIM0oLacNVsuFKkm76Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB3127
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Thank you for your email. Your diagnosis is good. We will think of a way to=
 correct this case so as not to disrupt the proper functioning of other USB=
 adapters whose drivers share this code.

--- Stephane


De : linux-can-owner@vger.kernel.org <linux-can-owner@vger.kernel.org> de l=
a part de Fabi=E1n Inostroza <fabian.inostroza.p@gmail.com>

Envoy=E9 : samedi 9 mai 2020 21:05

=C0 : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : PCAN USB hardware timestamps jumps forward




Hello,



I have noticed that sometimes the hardware timestamps shown by candump

jump forward, look at the following candump extract:

(0000034679.461888) can0 123#7003000000000000

(0000034682.263253) can0 123#7103000000000000

(0000034679.472170) can0 123#7203000000000000



these messages are transported in the following usb packets:

Time        Data

7.436864  02 01 08 60 24 34 7b 70 03 00 00 00 00 00 00 ...

7.441998  02 03 42 04 01 c4 7b 40 01 00 08 60 24 ad 7b 71 03 00 00 00

00 00 00 ...

7.447143  02 01 08 60 24 25 7c 72 03 00 00 00 00 00 00 ...



The time column is the time shown in Wireshark and the CAN messages

where send approx

every 5 ms.



Reading the source code of the driver I concluded that the jump is

caused because the second

usb packet contains 3 records, the first with only a timestamp, the

second record is a error record and the third contains a data record

and the timestamp of the data record is before the first record and

the driver detects this as an overflow.



I've attached a patch that fixes this, I've only tested it with PCAN

USB ver 8.3 latter upgraded to v8.4.



From 34dccd02d430b8bbb68802ab304c7e2f9f184871 Mon Sep 17 00:00:00 2001

From: Fabian Inostroza <fabianinostrozap@gmail.com>

Date: Tue, 5 May 2020 01:06:40 -0400

Subject: [PATCH] can: peak_usb: fix hardware timestamp jumps



Sometimes the adapter sends an internal record with a timestamp

captured after the timestamp contained in the following data record.

The driver interprets this as an overflow in the timestamp and produces

a jump of some seconds for the messages contained in the usb packet.



Since the adapter periodically (~1s) sends records to sync the timestamp

then this delta computed in the driver cannot be bigger than this period.

Use this to detect real overflows.



Signed-off-by: Fabian Inostroza <fabianinostrozap@gmail.com>

---

 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 ++++++++----

 1 file changed, 8 insertions(+), 4 deletions(-)



diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c

b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

index 0b7766b71..77d734731 100644

--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c

+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

@@ -130,12 +130,16 @@ void peak_usb_get_ts_time(struct peak_time_ref

*time_ref, u32 ts, ktime_t *time)

     /* protect from getting time before setting now */

     if (ktime_to_ns(time_ref->tv_host)) {

         u64 delta_us;

+        s64 delta =3D (s64)ts - (s64)time_ref->ts_dev_2;



-        delta_us =3D ts - time_ref->ts_dev_2;

-        if (ts < time_ref->ts_dev_2)

-            delta_us &=3D (1 << time_ref->adapter->ts_used_bits) - 1;

+        if (delta < 0) {

+            delta_us =3D delta &

+                ((1 << time_ref->adapter->ts_used_bits) - 1);

+            if (delta_us < time_ref->adapter->ts_period)

+                delta =3D delta_us;

+        }



-        delta_us +=3D time_ref->ts_total;

+        delta_us =3D delta + time_ref->ts_total;



         delta_us *=3D time_ref->adapter->us_per_ts_scale;

         delta_us >>=3D time_ref->adapter->us_per_ts_shift;

--

2.26.2


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
