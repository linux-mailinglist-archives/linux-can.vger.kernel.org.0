Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47D925833F
	for <lists+linux-can@lfdr.de>; Mon, 31 Aug 2020 23:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgHaVJG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Aug 2020 17:09:06 -0400
Received: from NDMSVNPF101.ndc.nasa.gov ([198.117.0.151]:38406 "EHLO
        ndmsvnpf101.ndc.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHaVJC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Aug 2020 17:09:02 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2020 17:09:02 EDT
X-Comment: SPF check N/A for local connections - client-ip=198.117.1.146; helo=ndjsppt204.ndc.nasa.gov; envelope-from=brent.g.gardner@nasa.gov; receiver=linux-can@vger.kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 ndmsvnpf101.ndc.nasa.gov 846AE400DB4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov;
        s=letsgomars; t=1598907590;
        bh=90xaom3PY5z2lkh/jBO0Bm4HFxkYg1ZoxTCtDXQArBM=;
        h=From:To:Subject:Date:From;
        b=dXmJUfyG8MdQN42mRwBpAhKTU1m6atrBB5OxNqbu3qVWHGGPCAqW3kTx0skG+Mw2P
         oKMduM1u1H2q9kosi3gTSxkQEIoFPLrupgpH2vpxZ24SbG9lT1Clzoj5mkQYIuD+v9
         F1pLlmTqu5Xkvepi6CbQ5yKO9S2U0omwBcsBN+YijJAqHv3t85WrEeCUnhk2/pwf89
         P7TOX7gfL33HovmsO1nCwmixKp0NjlfvZpJeBlOmMkAhLaqD+h7nHOxQIkMZdWMnc9
         38O0c6lPD4WMkzrm239fVokBkRNIwl90T3CoYkS+WzAUOTZdHqejuySGCT3r695+at
         2pRHsG/pR+KvQ==
Received: from ndjsppt204.ndc.nasa.gov (NDJSPPT204.ndc.nasa.gov [198.117.1.146])
        by ndmsvnpf101.ndc.nasa.gov (Postfix) with ESMTP id 846AE400DB4C
        for <linux-can@vger.kernel.org>; Mon, 31 Aug 2020 15:59:50 -0500 (CDT)
Received: from pps.filterd (ndjsppt204.ndc.nasa.gov [127.0.0.1])
        by ndjsppt204.ndc.nasa.gov (8.16.0.42/8.16.0.42) with SMTP id 07VKuG6E023156
        for <linux-can@vger.kernel.org>; Mon, 31 Aug 2020 15:59:50 -0500
Received: from autodiscover.nasa.gov (ndjscht103-pub.ndc.nasa.gov [198.117.1.203])
        by ndjsppt204.ndc.nasa.gov with ESMTP id 337j0stm13-1
        for <linux-can@vger.kernel.org>; Mon, 31 Aug 2020 15:59:50 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (104.47.65.109)
 by autodiscover.nasa.gov (198.117.1.203) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 31 Aug 2020 15:59:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+2L8ds4t56Zr7fdDkvSJU7ir77+V03GXcnY4+o4PNc0cNrvsGNQgqgQWCDwtwS/WhYOOv8p8N4CgFlcY+57ghjhstC2muQYdIsVYyx+WPVeuxjzRPYw0jxPqcY8XWaxDYufJOvMUsFrV8YedEouM0fXIsRiHM7G4Vd8VCGtoaHceeN/5oXszv4fuWhq308M+jJQcyKT0uS7VkkMaVimmzKAysW7zsW3utsldUAKoeIE+fhf/In7Gt6Ahfh2vZhH/TyLyGTBQJLrGCuoU9huK+1nMaheoNZXbCe1THbN1C6xaPm1xQmUc9jtVGwHJNb6omY4jWt+bBR4r2zgN8uXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90xaom3PY5z2lkh/jBO0Bm4HFxkYg1ZoxTCtDXQArBM=;
 b=ZYZK9Mty8nCFyZV2gF6rmh6rXhmPZG2ukZiR4/yADnuDGIkI0GsWtK+nnYUeUItLPYn28cPrZ/oybHlP1P7XIQsdDDevu0uF8jVdkcSBAFdAPK50egjixTGBmywH8G4ZnGS2D3Xlfclh0D8fmxlmhXJ2ur9ElXmPUHmywiDyyL9Iw6m8sxsabOovFxxHHefHkkaeH4IksK4oARQC1oHBC7Qvce+ljHRnW69ktrl541uCDJGClqnO73oXk4jOE5u2gg5xG49zZE5qj6YfjgjeLpwzlrv+UFp278xcHcqZLoikm+4bF9XgRz6SFkReH+QGSFatxVSBzIXZBq7uFyB7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.onmicrosoft.com;
 s=selector2-nasa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90xaom3PY5z2lkh/jBO0Bm4HFxkYg1ZoxTCtDXQArBM=;
 b=F0MjIKpZyePEGFOw8B3sOrRRLzIvu4yK0lMRLFzBPc8flGrS7FeMgIaOWwy0vZ9FOAkI+LDstuZTb8vp8j+YknFa5t+GToy7VbKltrGNbfGOWZbFd9p7MQnQlCwDPmPq6gw2Fz8VdO0Hau/Naz4EYOHLlQtfIUcfa1h0vZ6I1mI=
Received: from SA9PR09MB5280.namprd09.prod.outlook.com (2603:10b6:806:45::9)
 by SA9PR09MB5950.namprd09.prod.outlook.com (2603:10b6:806:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 20:59:49 +0000
Received: from SA9PR09MB5280.namprd09.prod.outlook.com
 ([fe80::e1d1:4fda:b703:ce6d]) by SA9PR09MB5280.namprd09.prod.outlook.com
 ([fe80::e1d1:4fda:b703:ce6d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 20:59:49 +0000
From:   "Gardner, Brent G. (GRC-LEM0)" <brent.g.gardner@nasa.gov>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: Need help in interpreting ip status output
Thread-Topic: Re: Need help in interpreting ip status output
Thread-Index: AdZ/0vOVnRHTIIfeSG+qWYyj9HrxLA==
Date:   Mon, 31 Aug 2020 20:59:49 +0000
Message-ID: <SA9PR09MB5280A7B98637AE7B7A0014B4D6510@SA9PR09MB5280.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nasa.gov;
x-originating-ip: [192.92.192.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d06267e0-754c-49ba-7803-08d84df0cc9d
x-ms-traffictypediagnostic: SA9PR09MB5950:
x-microsoft-antispam-prvs: <SA9PR09MB59504189C98C003C3AB2DE46D6510@SA9PR09MB5950.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fm7pdsdCye2r2s7iSS/cgcfD1bGjN1Y4NNSPtszQvrDGdAa+IXdploYcj91yj1ifcUqYSGQpzKbZh6Bg4W/fpC5sjkwm7H0MpLwCniuhSu9bZKc3UGnX37Q+RaeKD4Qgh3e+gI4WWiiiZPSf9874bG64BfewOVQc7rtf4OMKkHTXXUgzbv/+G0vTY5N8CySmH/Am88djY+uYqHZKW+OiRgOfR1dxFNSo2JcwuBP06yqzPWfz+oJvg+JW60zBuFyi+DmYjy/2m7J9ccnL5uszYpDvls37wVU9Z3NZ+nI8MCKd3MAE/YH4BhQQ+UXLv/eQiqS17qIosdkXCy7RVO2cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA9PR09MB5280.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(8676002)(26005)(6506007)(478600001)(186003)(66556008)(7696005)(76116006)(66476007)(64756008)(66446008)(83380400001)(66946007)(4744005)(9686003)(55016002)(33656002)(2906002)(52536014)(8936002)(316002)(71200400001)(86362001)(5660300002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2Nk5ceB0E1z+vWdzdrqk4GtX/5htAnD639qa+3GUt2xS0xp/dynJyVP3YRYKBoL7z1iZ7fXm8jCozuq0eXvwNJwEXwMK3uf2PgTwr3Sz9YYymXDtGkr8CAT0orX8KkOiNTvfnRgC5lOr+SiKk4bLKKiXHOng8YXbjyStbiw6zGQ6k77ZCfJNj8cRiu34pSOtLvKHZpafvznOP0NMe7mBEOrmdnaVNKz5crNHNxCTawjcWTQk4oCfA+AakwsDi0uskgiiCDQB2x8ZoRNkkMBamqDfkIbf027sES0gIPwPWpwwI2HmJhNN25sH9amqbDauMux9ViJ9qpMjjZ+1TuM13ADTo8N90EMef6ZWe5PImf5gvW3BYjoEUcD2Zch6ml2M0eBU4BadZ18iUOn5CFLMnhnMQgIpQRGONYsD0VeicNh+h84BNxdvxPacvsjER+UVeQTFSUnxAE4pKGBTEVsv9n1KqSYySFz4D3iaPvYqkcGLdDzm7B500iRyWNm2mSRSgF8ZjPNxtYWSl+UBxi9FQwkpSuWP8D6wqEufs/1Lm0OLyJqY3HwvhEcfCq0pwljoj2nyjti3C9OkBMJeMbg3+FFPBeeELqyO+g9/r3cwt5xJJPLvfj37R0oeZHowJECAUpvdZrMj3cuUON4IYoAOoA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5280.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06267e0-754c-49ba-7803-08d84df0cc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 20:59:49.1375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4qV9O825ycEdmfyZPTF8vQu6o1zcUDVfDXbdCoLlbdsmz57jSzKlLA7Ptc55X30tfeHSTofKRF1fVBEmUlOMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB5950
X-OriginatorOrg: nasa.gov
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_09:2020-08-31,2020-08-31 signatures=0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I apologize for not knowing how to join the thread in the subject, but I'm =
trying to investigate similar issues.  I'm using a Raspberry Pi CM3+ with a=
 MCP2515 dtoverlay.  During moments of high CAN traffic (and possibly more =
prevalent during high CPU usage), many RX overruns occur.  The physical CAN=
 bus signals appears sound, as I can verify the dropped frames are present =
and valid with an oscilloscope, so I believe the issue is related to the So=
cketCAN driver.  Did upgrading the kernel help?  To what version? Thanks fo=
r your help.

$uname -a
4.19.118-v7+ #1311 SMP Mon Apr 27 14:21:24 BST 2020 armv7l GNU/Linux

$ ip -s link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEF=
AULT group default qlen 200
    link/can
    RX: bytes  packets  errors  dropped overrun mcast
    14992      14992    71      15      71      0
    TX: bytes  packets  errors  dropped carrier collsns
    1364       3028     0       0       0       0
