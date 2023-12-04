Return-Path: <linux-can+bounces-66-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C06802E4E
	for <lists+linux-can@lfdr.de>; Mon,  4 Dec 2023 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024EF280EA2
	for <lists+linux-can@lfdr.de>; Mon,  4 Dec 2023 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48EA14F94;
	Mon,  4 Dec 2023 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XdahsYPR";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rBfkwGL2"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6ED7
	for <linux-can@vger.kernel.org>; Mon,  4 Dec 2023 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701681370; x=1733217370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gMWNLfvXt8mNM/pyHjB/TmLFtRVvAzWzl0rpuilljjk=;
  b=XdahsYPRiTSuJ7EZXXSgOAjtvU4datfG6Cj7qYDoeqbQV91xf+EbP7pE
   +RYdvBtls7+Wd6GKctqsf6wwTGsf3DdUdLfdYRFq0qBJunNbDzIlKszqz
   Kpj9tEjEoyDLdrRVKuCV+ZdW1USJTmUGpGPETXtXJBBZdPclDkgYcni6C
   PpvGhVs9C8tv1SwfcAlvCPOSUO2EsTbPJice5GwPVwNZQx/9F6+gQFonX
   L0ozOQwsGPzneHqmyeO5iA2O0CZj1+Md5XQdzTRCvyg/rorAYeekq+/nY
   t6IoXYj1Npk12VAsv1a+9ekvxFZy/xWhH47byccc0NgA6JTg4IL6gVCNH
   Q==;
X-CSE-ConnectionGUID: QlINW8AFSgSXHepO4S7RdQ==
X-CSE-MsgGUID: rJRLel1vRaqoft81aAhw6w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="13533346"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2023 02:16:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 02:15:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 02:15:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYK5Uh0RWDXAtRWiUDGpzOPXVjkaeX2Mm5aBg6vI5kduBRnbZFuA8+RWmW9odzMXy58v6PeDvU05YBJYmMrgFux1xZBu+X4dZhJ0L1hOG52MXEremqDJPOW1au4nV/b4jt7A8RZH2Vvgm1kB49mIkYLHJZqJcsPAdKd+ur/G67H3aPxlkz92YRqnb6csJIgy+1tAATBEi+lv1T6+Vvgo0VUjc6hXRYy9+G6A59x7W/OYzc4Yx1x+vzro5DEifqnYxjoR2kbE9P+aAoF3ygol/pRFXrKElLUi7La0yHKGhLv8tgQw2Am6fooG4W9LSVKZhf7ad6dhQzwMdQZGzv+C3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMWNLfvXt8mNM/pyHjB/TmLFtRVvAzWzl0rpuilljjk=;
 b=maJsue/ZA18tIvqCwiCM72qlpni3negDwcHw6RIAykkARwCDbnLwMitHMM6+/i528alAyB3vTY6OYrIIVFUl9PV52MIl/bPHNaZqrf5PwB0J3oL3SiJgnXffGzp4o6Cq2N+w23g3O22N4/ozawaoUVRgZgN3PaIC46lEG25CMzefDs0HE4kvjn8fl7DkMsR3dGY7NNXJ6udZ3RQHAzjXhj14U31psGKqpp/G0DH+ZThgzJ3X2AMcnnDfgkHHSDKl/Kqi5j/REwWDS/RTuczuSo3OSol7uMvsXnSAgkt2fYbsT4teIP7a9t6hTTzIKX4Qa25413G6Pp4xesLmUePvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMWNLfvXt8mNM/pyHjB/TmLFtRVvAzWzl0rpuilljjk=;
 b=rBfkwGL2+BL8G5X0Ft78WhVzGKR5Ra0cDVmKM5x+AqJ2xdPt2qeOBznAUlAw9WPId5UHEytvRLS4Ow76epmaW19X3NLaGulHleAZrvJPAQZz+TsfS2L1DU1Dr5HCh+GEYmN/TVwUyWOe8IyF5iGX1Ph6N8dxVDwd3bybayN91pfeK7DgG5DX5mBA4aXRVzw0SmveuboubaQqznPuR/Lj8sXo5aoxn3P6EYq18bJHWFmmlYmWX/klcob6E6SRo5Me34AsYKfTvGKoiJOyTeDmfM9zFY3QAjiaNGEYlce3lbKbaPdxI9JLIHQMwcVUC3EeVhXjNsJO6ioepLdP6l/L1Q==
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:15:42 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::ab19:d726:238d:26a0]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::ab19:d726:238d:26a0%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:15:42 +0000
From: <Thomas.Kopp@microchip.com>
To: <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC: <mani@kernel.org>, <Stefan.Althoefer@janztec.com>, <kernel@pengutronix.de>
Subject: RE: [PATCH v1 0/2] can: mcp251xfd: better workaround broken TX FIFO
 STA register read
Thread-Topic: [PATCH v1 0/2] can: mcp251xfd: better workaround broken TX FIFO
 STA register read
Thread-Index: AQHZMAhpN7JUDxBqvEuU2qKhDmU6o7Caw+/A
Date: Mon, 4 Dec 2023 09:15:42 +0000
Message-ID: <BL3PR11MB6484F25C35C5E0A9937FE20BFB86A@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230124152729.814840-1-mkl@pengutronix.de>
In-Reply-To: <20230124152729.814840-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|IA0PR11MB7330:EE_
x-ms-office365-filtering-correlation-id: b23e7878-e9c6-4348-a925-08dbf4a996fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHm1GyR6oyAAjvA86dDQavdiz2ubAFSS6BEbS2c5GAaI6hetSG6/GQlq7pfGd7wKeBD1/xFNdRXtd/lMalTSqnvPMjLK2z2nVXxHF4xVMfRUHr5Y6yIVjKjQbr0FF5idpDyE8CuT5PFscmV1ns7oNbpJx2adWSqqNtTclskr/rFLgk8DeGooynlewFLbr2EFIc+NajbzogZ4C/k2CXYYeXha+dkg54c2LN4pGY9yP3iDMJcSH+8UDfk+HaM99U3JA1ZB5ZODuXl4fqW1B6EypotNLb5evonCKQYlhi4sOKdcLichHGhvbsw7RJfUgOfKmOX6V7uBfOQPOEEyloeJym2a8JIKAzY+bchqFTHD84DEEGlp45ajqbUNUpIPzwB6xUJJd+1AihXo2GS5n7ezZ2t9oGDKRlDqMzQnvPTUkxMtHtpgj3QPlXAwwUWE2C7VdlaO0s865wRiBA4EK5OsxLBgCQeJYg7XOQrlgnbGxsZ/pVJtz+dRDGpu5BlZVmOgFZh5eOIpBYJiOnJjkbbQ9N24rrUdnuLwGaGko2hwgJ3e1HtlydUhWj7eq3wbomZv1KVLOTfLevyo/WkxqeiEiYw/GbRQme00q8rvMv1RAPfXLtfYh8DRqnpx89dr1IGWPqGdt7+pVzcjqKfacFP53g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(4326008)(8936002)(8676002)(9686003)(6506007)(7696005)(55016003)(83380400001)(26005)(966005)(71200400001)(478600001)(110136005)(76116006)(66476007)(64756008)(54906003)(66946007)(66446008)(66556008)(316002)(33656002)(2906002)(41300700001)(38100700002)(38070700009)(52536014)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qVslCcbpkKTQ5iOWaSK+ry0DTi8MlI2AhtruhZ5xbcsZajAMfz/P90tbUF?=
 =?iso-8859-1?Q?v5LFBpr6Ruu3VWWm7vclwqZ81D+CT+iaEJRO9rEPDYZNTeZ02suwEsbuM0?=
 =?iso-8859-1?Q?Y9HhAlYJiWj3Pd3POWs9e6n1McTglUa/weEoBDSRjydC7Gpm9Y/56tCfDg?=
 =?iso-8859-1?Q?Gjs1eiOtmK8qOdEybTyNism0RmVxoc5HGpKg89jKoTgx+0R/URgo0mNLVb?=
 =?iso-8859-1?Q?/JpK+UUNJI/DYQVVIRLEa3dRtB+f4RoKXI8eaTH8CWn5cQXBc3pHDSTlNZ?=
 =?iso-8859-1?Q?NckcX8qddkeDTuD1jmKbORdDi3LrzulxdLwX/9h5OYIypwCNrEx9NjjbFG?=
 =?iso-8859-1?Q?J+RVFkrTku3X7bjo6jEEoY+t1odf1BBdr1xSdlzy7d4i9EjFNSZx6mkm3W?=
 =?iso-8859-1?Q?qKTGc4SFX7GJet/hmlwHGE7shloWAVzJc/SUvdMR7NL5og/MJxYa4E6ZYm?=
 =?iso-8859-1?Q?WE13EuR4Ac1+AGEAUstj8BfYu+dgFayJXIzRgluOz0u5leIZBhDK07QHFg?=
 =?iso-8859-1?Q?lC290ZOQuvAL5OYkeIE+XYaeoL2KtGCRz2KQK99UCTM/QV2YqjAYZYZ5/l?=
 =?iso-8859-1?Q?SgAtAO2NkoKswdvVye/sX8pR8RCFUX4ulCimQ18mn6smuCvJkYpUw1s/+m?=
 =?iso-8859-1?Q?ytzcmrXq7/5aR0WAPeuL44Kdu0KCupS3EUQM0rJM6PJ7ptSk4Nwi+Qj5al?=
 =?iso-8859-1?Q?v254X2c3V67lvYAPiIonyd19IsCIOZHhVMOfgbavyNqAg3dRh3p1jonqHM?=
 =?iso-8859-1?Q?KPwC19+5IOm/khrg2vbLv6SnEVC2EZCEfFbtz26C1ctliTyqrj2x3unywV?=
 =?iso-8859-1?Q?R7Gr7PPTQuMFG4wMy0Kc5VCA/gSK8kMqiajJLfA+uKQ4bvRCdAqwsyo5wX?=
 =?iso-8859-1?Q?YArGYIE6twAJUj5aF6U5N9AyzOrHEKn2YvNlfzlVayxtfq3+giBYXebNHG?=
 =?iso-8859-1?Q?lX8ZHJ3s9ldxlf6UnDRsU0pkUVz60zLPEh1A7f3E/+o7Yl86TBOUNBIc8t?=
 =?iso-8859-1?Q?hOx4riQTHxT6j0MdlXOf0hNjIqJ8AmwEx0j7aRI9qzxiJWcO0bpqrjKnED?=
 =?iso-8859-1?Q?JfKagMwZPAW++XmqHACFylqTIdwEssDbNf1Mgz+TorkjAdBv2JS9KSM9Xj?=
 =?iso-8859-1?Q?RLOsE50ox+nsDJhKjBZVhPPILX7ufy5RXcvYhtO4O07KVM+lVZtEHh3BKU?=
 =?iso-8859-1?Q?vuGHukwMSLNi3zhevkFVMxjxCvVBWGy+IlowjE+pt9UcTuJ+rmV6SWD8Ql?=
 =?iso-8859-1?Q?H+sQ78RrYfhGI/odwO6hLCA8Pxwn8fnmtJPS0fd1T2peTIjehwLDR4OtOc?=
 =?iso-8859-1?Q?3LLUmMWMlAbUeahbRRrucTnfVBQD2mlmx8zwlpMyznSYRZ+JuTW40yvEC5?=
 =?iso-8859-1?Q?oamvQbQuncMe3nE0QzePgvcs1v4HdJ3GwZxBe7wmEZme+pSr1/PRofotH/?=
 =?iso-8859-1?Q?GFCUIX2di3FzhviwYPqb+iJ/QwSIXg0QAMBXaJc1KDi5Lav1BX0FOrEYVS?=
 =?iso-8859-1?Q?HEj1TW32OHLZrV9x2/OL8qIpxNdZ3aopZZik9+A34rJcu1PQHAF2CWY51A?=
 =?iso-8859-1?Q?J0OwxGFFDp96pb/5iveGjjf+Jra5MuxXUURVzEMwYLjOyFeZsSDdRFoqt2?=
 =?iso-8859-1?Q?zmJiIq64ZqYkGDpUE3xhzOr+vEZkah1vup?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23e7878-e9c6-4348-a925-08dbf4a996fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:15:42.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UC/Y7WY/DFICOtaNegJk9wzFByS5xzrGz+iVpLBDGScA3GQJzZgTMR50AWJ///jK0zCmG6Wzouo5y5JogdT2JDGLeEAKkADMITy4n7Mp0AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330

Hi Marc,

> Hello,
>=20
> this is an attempt to better workaround broken TX FIFO STA register
> reads. This series implements a workaround similar to the "workaround
> broken RX FIFO STA register read" [1] and should be applied to a
> kernel tree containing that series.
>=20
> This gets rid of the "Transmit Event FIFO buffer not empty/full", for
> debugging purposes you can enable an error message by adding a
> "#define DEBUG" in "drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c".
>=20
> For every detected error the tx_fifo_error is increased.
>=20
> [1] https://lore.kernel.org/all/20230119112842.500709-1-
> mkl@pengutronix.de
>=20
> regards,
> Marc

The new erratasheet is finally live: https://ww1.microchip.com/downloads/ae=
mDocuments/documents/APID/ProductDocuments/Errata/MCP2518FD-Errata-DS800007=
89.pdf

The analysis showed that this specific bug only affects that one register w=
hich is covered by the workaround. I believe the workaround worked back the=
n on my boards. Was there any feedback that showed issues with it? Could it=
 be merged now that we have the documentation in place?

Thomas

