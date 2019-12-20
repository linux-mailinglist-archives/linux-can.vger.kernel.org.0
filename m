Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1051D127365
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLTCRo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Dec 2019 21:17:44 -0500
Received: from mail-eopbgr1360122.outbound.protection.outlook.com ([40.107.136.122]:40794
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbfLTCRn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Dec 2019 21:17:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeyS9yv/7OhhnjFJPYjqM1jCpf69YA9BexFr6nWwokLxd363XBRJHLvf1bTU0rTGJGOqlx7OoPLVbuCt7npocrSA3OseZG2M4tOGmbMWcDsIcY4uPE3yx520sKejKt/MznJSyydTJaNlCc7mGi9VYhxLd3/wfsDMnJWCBi80wtq+Gcnip5bIShrBSsUVyyxOgqsNs/ZS5rDT1hwt7ecTWEpU2EXKv+nmvjhguLyNTo+v7N5pLvdqnNelGN38sSQakEOWnJnxlUEN+B3A0SaiYkx9J0z4/tK57Fc/9KqMbsVwiz5McuX4ttja61/vkGuipR84UJ2aY7jR9kX6emX8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBBElCxbxZj5QBpvX4Liukx8loJZM2+bo4Y3r7KDgnU=;
 b=fJleooj//OwABXWReQi3xlnSvCv+69Hhb2NdpndlX+NR0Wr6MIHS8xL3Ib1gveWKozviQGg7hfixxJ1dRZEJ9HEIFsH/SIk81NNU+m0ahyXLsJtYNARa6kGhq3MO4BgFXrBzBSq4zn/YyA+Jqa3/+Sacj/bGJf9gvXV+J6gxr9Z/6LzYoyoKTKX2QkPaJyh/w7+IMl9u4Qh6n5FfzsrvuHQkfkYBRGZ4bZjY92lMLai0EIJtB3/WrcYXkabitSrEyazMJt4o6mCzkpVMCiOH+ro/psIdO07ITIjnl0q6ELclID4BIHoCBA6RPNI/7EPZepg1o2rjJZZvg3XoTecX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infact.co.nz; dmarc=pass action=none header.from=infact.co.nz;
 dkim=pass header.d=infact.co.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=infactltd.onmicrosoft.com; s=selector2-infactltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBBElCxbxZj5QBpvX4Liukx8loJZM2+bo4Y3r7KDgnU=;
 b=La5V7S6fSuA77dHXiFZbGwGK8lMLgcQ7XjeoYLFHsoIvAH3Ejp00A+uXoQQnqmEvaUnN2WkSCE3LneqTXeZ8CPc3SjYEwXOzLDLtO2oKM9ZkK8s/Bk28ZowGeJYkPWEGfn01mMgrM4qstKf6SKZO6QQ+v40QHHgSOB8Vdg9U6Hg=
Received: from SYXPR01MB1230.ausprd01.prod.outlook.com (10.171.37.20) by
 SYXPR01MB1327.ausprd01.prod.outlook.com (10.175.211.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 20 Dec 2019 02:16:37 +0000
Received: from SYXPR01MB1230.ausprd01.prod.outlook.com
 ([fe80::bc07:7cf7:d07f:b48b]) by SYXPR01MB1230.ausprd01.prod.outlook.com
 ([fe80::bc07:7cf7:d07f:b48b%12]) with mapi id 15.20.2559.012; Fri, 20 Dec
 2019 02:16:36 +0000
From:   Michael Frampton <Michael.Frampton@infact.co.nz>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Backporting J1939 and mcp25xxfd
Thread-Topic: Backporting J1939 and mcp25xxfd
Thread-Index: AdW22y0uJchY1T2lRXyiqyq7qbqcaQ==
Date:   Fri, 20 Dec 2019 02:16:36 +0000
Message-ID: <SYXPR01MB12301FF2AEF360FD9F013AA1A12D0@SYXPR01MB1230.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Frampton@infact.co.nz; 
x-originating-ip: [203.86.200.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a7a0083-8913-498b-beac-08d784f2a44d
x-ms-traffictypediagnostic: SYXPR01MB1327:
x-microsoft-antispam-prvs: <SYXPR01MB1327B07F1F732C4B555927C4A12D0@SYXPR01MB1327.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(39830400003)(376002)(199004)(189003)(26005)(186003)(7696005)(76116006)(6506007)(55016002)(6916009)(9686003)(71200400001)(2906002)(8936002)(86362001)(5660300002)(81166006)(81156014)(8676002)(52536014)(966005)(4744005)(316002)(33656002)(66946007)(64756008)(66446008)(66476007)(66556008)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SYXPR01MB1327;H:SYXPR01MB1230.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infact.co.nz does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HtekI9SV9+jRJLmS60Lo7vO1/A1zdqPvjMGdLjYLlgBY2r+n3KmQIJOIbFLurcGQDNEijcGFQqSrRrI8A33IHbE15i8ISmCYlhDwMrnceUmzQgilZvWFZ/sb49JqjTuVDiDV57HbqByf4lBhp4jm9MEVB+AHv15NN2RwawOZu1rApXzOFnxBnfKTkBgLylCdIwxi7VA3pSITaYx/O7elfwRgyFvZJkYaVLfBj07Bt73Dpt4qdsXNhChelEj368Pt47vDQYv7bxGUhNxnKCq4tgsiFkCcEApUfwwjuVTPUUYxOYILxQZJhD30i4TUFYJN5NVhCkkpdLDqbOmyiugZyVIBNu9hl0elQyq5HQI8l9KinPs9/UvRzom0xr5Kftd9A3+cHBt9ZrT/0vwHatgjPabL6JIc6yopYK4kZEObeoK56/vtsKlCjfG6pE2oqMySJ4Dk4lKj3ALl1aKiGJpxJv0oPM1HKKffmxTq1zeBzMI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infact.co.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7a0083-8913-498b-beac-08d784f2a44d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 02:16:36.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d3186c43-3bd7-42ae-90de-3e94668e5828
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MmSgaDhzalOpnynXd7qPuKT6e98xsaEbDPvFErEdaIye+XoYNPEFhNIqcstA72RtJHK5X2LrFUE6RkuBT+hrpPASIP+eyfG0IyAdm1LFJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB1327
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I'm interested in porting the J1939 code and MCP2517 driver to an older ker=
nel. I'm planning on using the Qualcomm 4.14 kernel.

Is it possible that working versions of this code has already been backport=
ed to an earlier kernel release, which I could then merge into 4.14? I saw =
that Romain Forlot has asked a similar question here a couple of months ago=
 https://www.spinics.net/lists/linux-can/msg02539.html but the thread was a=
bandoned. Oleksij Rempel mentioned that there is potentially and issue with=
 Rx/Tx frame ordering, is this still the case?

Thanks very much.
--Mike

--
Michael Frampton
Electronics & Software Engineer  |    inFact Limited
+64 3 3777 316                                |    +64 27 313 81 93
