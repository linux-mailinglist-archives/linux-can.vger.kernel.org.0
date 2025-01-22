Return-Path: <linux-can+bounces-2676-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24758A19465
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DA618883A3
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AD20FABC;
	Wed, 22 Jan 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="OGZFbHsW"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013006.outbound.protection.outlook.com [52.101.67.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F71448E4
	for <linux-can@vger.kernel.org>; Wed, 22 Jan 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557618; cv=fail; b=TL1kpVg8nGp7m8YRpaqS5OoxdhQE5hxw6Q+8qZU1VYYMWUYpsAW0CgWYp9UMDxqfOsY2xzThuAL888psxEj3pGGVD505K3l2TFR/0Tvbmm5qyeGNOk/IVv6kuSJhU6DkOVzDd+YNnFdWp+X0LWef/e/RpLbfvM960BHi2SaU/rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557618; c=relaxed/simple;
	bh=JwyD7pk+HjAuHQuTeLwToOMNw3o1QIWyEndkXSAMFvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WS2Tye2xtgrOEqAk2qEi9YQmoJC/uwa2Ukfk126pSQGY3WY9Eu6+xL25zIYVKZvuRqZgGq0hHL1janbrXYMmP0O6B2QcAK5THWo3HW/EFqjXInZR+xdlnGsRXUnHzr4COjq3zSeoGULG4wjp6EtR1zqTJNQZG9Lu7kNy/3sbEDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=OGZFbHsW; arc=fail smtp.client-ip=52.101.67.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQ3rX2/kKYxU0G5ewyfXxj1CoXhNqg2KUAEVkcz/KgyDvX5LjhS+0LtSVVCrRRFBGKMk9j2Drcs6ddnLicG8Vhj8wTp2dJmaHcDLT/uUv16PlJxdZZW41laRJqRRNIzRF7nYDbgbAE8gR/rXfT6DQ03d26lcxMoBjU9l88UgMf8wTXQXMwK1+STndB2GgkdWBflFkSAmmKqLkFAULrfLocOuyMBjP++nRr6z+SNsPu4epZPALq0ix712H0ly4QqFIENcpl/o5ylCon+LwD4Kj3UEcR7jBo6hDPs4KeD4FJtfvRQe8Fh4mplXk0O8yzDWy+NWCz7GSw92HnkOihil3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwyD7pk+HjAuHQuTeLwToOMNw3o1QIWyEndkXSAMFvI=;
 b=FTvjVwfDCWQi5eUuLB+RANg/7LH4sz5yzu1jPXfd8vdjDEuOBQeCkUBubsS2xgPBOhGPhZ86oAkgmi9kHwsN4VNSoyMfpUIS4aV5KkiqJ1sdMaDElW1S+Ka3R13YNHYVsh1wxawrn7ogMYJ1COlYdfIKkrp69epVqD7cs2ZS8Btkoe8aI6JtYaCxStV6SaH7u1MXwEgCD8Y5LGUoJ80inBIbckOTIiC3+vIkM+ebIrQYvgNf5gKgOuC3bwpgj7iiSQyzUIiVtmJ/eanxgGcCZDDgesoEf46DfcEAWu2Lr297NRkn7d5e8cF8fBBxBYvetSAQrh9w36oRrRoEqFA+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwyD7pk+HjAuHQuTeLwToOMNw3o1QIWyEndkXSAMFvI=;
 b=OGZFbHsWPAW3xJLWrqlYZQZRiOrDCPfVfztFR114bTjZJs/xy5AelBT1kmLwka3C/TltX32Sccd5vMvcakUnS8hodnLcB0K8fdtwkJEbZwbnUU8e1nyyUUzNAoZiRGj+3OeJWVOwsn+8kW6vzxLCXacdfc75fdBGij519ZoUhE1iXWMx24bLFHYMWpr4zDCoVLe5hmPRzPGWDFaIan0/A9IXWMmBZO5NTsEsWphwpB1g/aoashD7c+tgnx2pilMd+NjIxvyNGraqErP7ZisFxi7D1xmJ6dreXsVyV+csdlpguM4c2K4vIX2rgoj9XYfbIEMpyjx+Ja/eAGM8AHVpkw==
Received: from DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::12)
 by AM0PR10MB3201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 14:53:30 +0000
Received: from DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::104a:4c1c:9bb3:3036]) by DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::104a:4c1c:9bb3:3036%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 14:53:30 +0000
From: "Jonas Mark (BT-FS/ENG1-Mue)" <mark.jonas@de.bosch.com>
To: "EXTERNAL Kleine-Budde Marc (Pengutronix, XC-CP/ECP2)"
	<mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Streidl Hubert
 (BT-FS/ENG1-Mue)" <Hubert.Streidl@de.bosch.com>, "Jonas Mark
 (BT-FS/ENG1-Mue)" <Mark.Jonas@de.bosch.com>
Subject: AW: AW: [can-utils][PATCH 2/3] canbusload: support busload statistic
Thread-Topic: AW: [can-utils][PATCH 2/3] canbusload: support busload statistic
Thread-Index: AQHba1e530xoAcc4TECHTmKzq4uTZLMf5eMAgADzSoCAAB6xgIAB6q6g
Date: Wed, 22 Jan 2025 14:53:30 +0000
Message-ID:
 <DU0PR10MB70768402AD0511053562B7CCADE12@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
References: <20250120162332.19157-1-mark.jonas@de.bosch.com>
 <20250120162332.19157-2-mark.jonas@de.bosch.com>
 <20250120-vigorous-almond-toad-a28dc0-mkl@pengutronix.de>
 <DU0PR10MB7076197E81AB49C6C59ECE60ADE62@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
 <20250121-heretic-weightless-terrier-c99522-mkl@pengutronix.de>
In-Reply-To: <20250121-heretic-weightless-terrier-c99522-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB7076:EE_|AM0PR10MB3201:EE_
x-ms-office365-filtering-correlation-id: fbbffe40-275c-4663-5147-08dd3af48937
x-ld-processed: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDZ2NTZRanVtdXBBMkEraDF6YURDbERlUmwzRUNoK1NaNWVXdWVsOENxRlFP?=
 =?utf-8?B?ZXlJcWdieUMyNFZIOC8xZkdSLzd1aWQ3NXR0SDJHN28wL3VIalEzOVUzRXNV?=
 =?utf-8?B?UVFEOWdaYVQ1bkp6blp0RUs2blZzMjIxWFZMSzhhQUVaYmEvb2pvM3hSSHEz?=
 =?utf-8?B?eGM0TVRPaHd0TXJTM0tCNmhIZVBsREExbjlzL0w3NkR5R3hqeWt6SjQwT3Q2?=
 =?utf-8?B?VjM0UHZGTWRBK2VxWDN1SStDVVZSWmZFUDNJV01IdUxiVUNNbS83UEg2N3BM?=
 =?utf-8?B?b3NtOUdKNGQ1Sll5eFlOSGNCT0xzYmZyTDI5VGgxRFA3U1I4V2xBcHZaZ2Fu?=
 =?utf-8?B?QXk0cnkvVmE2MUl6cm5ibG5hRXpDZWRoNUJMVkw1cXFkNlZ0QzNCbHdLbVFo?=
 =?utf-8?B?ZUh2T0JHQXVoYUxoOGZwRkFxN0FpZmJNdTUzQ3lPMmN5WkRjNnF0b3ZQaU5q?=
 =?utf-8?B?WmwzSVE5S3BoOHJudkRSTDkxd3QwTzhURlN1MHlpK1pvTGxsUDRsU1dlV3hi?=
 =?utf-8?B?STdLRnNZSjgvbXkzUkljalhLTjZOUmdQTC91N2VBTXNuZGlOM2FZT1VvTGd4?=
 =?utf-8?B?QVdLSzFSc3FKWUxNK3NqSS9Da2FrZjRUSXlDaXlNZ05IM2lKd1JGVmZkaTdk?=
 =?utf-8?B?am0xKzBNcG1td3YwWitqc1pEbzNUWjNkQXIzV05LM0RQTVZzNnhaMXFJNUpP?=
 =?utf-8?B?bkpaYmJQdDdBZmp6SVhqTEVNSm1kaHVCbDlZcjhFZ1RIREJ2azNOSEZGL3Zz?=
 =?utf-8?B?eTJNUzRnTFB0c291amNJdUpLTWhBbWRZOEVxME5QaUdidkZ0OTVoT254ZStU?=
 =?utf-8?B?Y0cyTDdmMVJtR3FwMDJlOXdRZlRXeEQ1NVdqaWtKa2xPLy9LbzBrZk9iUmc5?=
 =?utf-8?B?d0xnUU9JekZLZFZDY0ljUjQ1MkpHOGQvei9EaHVqWWRGazJmbW14aGpKYUFa?=
 =?utf-8?B?YWZsblZvdWVVRE5hWGNwUWl4OG9QUVFtZUh5N3BJZGtTSjl2Nnd4U1JqZkFW?=
 =?utf-8?B?eU1ia2k0cWhwS1NtaE50RDBQRnQ5d0xXYlpVd0xycFR0RDBOQy9XWEtEUzd6?=
 =?utf-8?B?aDBDUkFyYmhIZmVzdEdoRUZRLytQT3l4UURONVgza0NVRlB2RDNBd2h6VTVu?=
 =?utf-8?B?V0M0cXM4blRHdi9ueW5zamR2R0NSTzFNOHBVdEg1ejM5YVhCTDY4MU5nb2ZI?=
 =?utf-8?B?b2kzYVliY1lxYnZmRnZNMWg5bzArYlVJMUVqdWdSY0JwbGFrTTRqa2dHM1FV?=
 =?utf-8?B?dWduajFxZEUxQWFUQXJWQ20rb0xrSjJVdStKUEEwZkM4dHpTNGx5UFphR0FB?=
 =?utf-8?B?ZzB6UFJ4Q0ltczlyQ2k0WlZ5WEErWURIZmFBVEVUNUJNUXpZQVY5SEpHRXBB?=
 =?utf-8?B?cFVRRjk1ZHpkUlpIS20yemluNnl4YXRTaDB1TFhxcGV6enh0L3grYnJnVWUv?=
 =?utf-8?B?clFHQW5SNDB2ZjdTMkljMmU1dWpzelUxNVA5UnFNdC9XOGs2RWRwNDJ0bkxC?=
 =?utf-8?B?RytXeWFDdGlEL0l5c0F5U2xhdVpML3RXclVxWk43Z1doNEM0dk9RNE5mcUQ3?=
 =?utf-8?B?QWRsbExVajg3VXRYVkE3d0VoL05rV2xHRE82L1ArSWtSUGpLdEx5S0p6SStk?=
 =?utf-8?B?MmI0eC9wN2xGU1Q3bUJQVXBRYXdoamFQMlN6Q01veHV3TDYxc3ZaWVNJMFZ5?=
 =?utf-8?B?VHE5U2pNVDFCRi9JekRCeVYydXdiZytmNHpGKzlXbEl0aVV5V0JyVWxSR2Z2?=
 =?utf-8?B?eFRta3RrODVXM2pmaE1hY0VOS2F4aHBSRDFIckZMdmJ4OFBCdjljNmpBR1lZ?=
 =?utf-8?B?N3lsWHczTWU4MGNUSVlrZHNZaUk2MVJqdVZEZXR3cUNlZTJJTytNa0hwU3cv?=
 =?utf-8?B?YVFVS3BOMVI0ZTVyZTg5SmNTdXNxelRUdEJnenRubmdKMWZuNTQ2cTNPZ0Va?=
 =?utf-8?B?MkxIV0E3bGtZcnQvMFRpVlBJdzNQeWQwQUMrL2lrY3JKUWZYSXZ0Um4wU3hB?=
 =?utf-8?B?aStmeXpMVnl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXpiRzBrWnFVSXFaWkJLanVSS09KUmxGb0M4R2E4U2V2UDFLSTR2bzNnSUw1?=
 =?utf-8?B?LzdadEdWeWZPUm5TdDVqSTBFbG5jNXdEY2kvNmc5VVZPR3ZJUHplV1JWNy9F?=
 =?utf-8?B?clRXRVd6K2JwdlJ1emRNMHZzelE1dFZmd1psQi96Y2kxc1lzeGJ3Q1NiT2Zx?=
 =?utf-8?B?VEs1RG03Kys5RUEvQ0p4eTdVckJKU2RxVVBuRmdjZXl3SmVKMWF0SnQ4RmVw?=
 =?utf-8?B?c3JkR0ZrdFlEaGhrRHFYTkdGblVJeGdNRXRSMnA4dm4zSHJDVmZUTDdFMDN3?=
 =?utf-8?B?ajN2aFhjSkMwbHBwa2owcEg4WEpiSzF5SVIwei8zTXAxYVlrVCtOQnFydEhN?=
 =?utf-8?B?SUxodndMUVlJeWJBd3ZVT3Zhb04vZ01VUklyVWpQdkNVWnNhSFd1d3dwcVUv?=
 =?utf-8?B?dXhURFhxMVdHNzdpamJwZzRmNEU3YUZtbUpFQmZ3VDExUndSQmJuQkZzaTFh?=
 =?utf-8?B?UVdCdnZ5ZTFCcnp0L1N4aFpEL1lZUHlkMnJXSnpQc0xicXFwekphM1V2ZGRJ?=
 =?utf-8?B?UWFqMFRoaGFyVG80NzlIeUsrc0txeWlSRFdCMXp3M2hmelJOZmdkOGE0Mnhi?=
 =?utf-8?B?NG9hR0ZYeFkzWVJQUnAyZWNzNWJSQng4THpwS3l1UHRWa0NDd0VUZzZCUU1i?=
 =?utf-8?B?RkdmODRJaEdFakRvMGFRMldNZG9lOTNUN0dleGFUMmNyd1QvYWJvQ0toWW1o?=
 =?utf-8?B?dTJFeW9LQ25NMDJnVTVFUlpSa3BVSFdaZCtwcC9UNXFGY3AxSEMzMEgzYzcv?=
 =?utf-8?B?cEdDMHpWdHZuenNUTkhpMzRKTkQ2T2xLa29NSkhESHI5Z2lmb3FmSXQ2Rlg5?=
 =?utf-8?B?Q0hlSWFicUFVSTVPVUNPbHptNkNMR1B3WTgzVFYwYWR2OUlHUVpmZGg0ZFNw?=
 =?utf-8?B?OCt6ZXpyOWcwTDNvb1NTM3Vad2lWY3p3cVM0blJDeHp2V3ZiOEE5bWREQTlq?=
 =?utf-8?B?SFdLclA5dE0rRXNpK3Z3bzNrRFJCNDV2THlYelhYQW9ZNE9ZZEwyZ3J6LytV?=
 =?utf-8?B?NlFwckZ0VXVvZG5wNXhyRWQ5a3A4K09mL0IzQ1dBbTZZSVFXU2VnVS9kZS85?=
 =?utf-8?B?ZG9ZeDFRVkYvRjdUZi9ILzcyRnhLdGhvM3c1NUNFb2pHK1Q4SzMvckpUV3o5?=
 =?utf-8?B?R2pnbTltU2hFM1diMWkzMjNrSjQ1Zkc4OCs0b3dKQlI5Si9GcjgwY1BFR2h1?=
 =?utf-8?B?eFp3aTlVak9sU0tWb1BrbmRWUXczNlpMdnlYdTdEbTlIRDBtMHQvZDNWRGRy?=
 =?utf-8?B?QzFzaVd5OXQyMHZ1MmtJNUJybnBKSFZxcHlqMThRbUJoREJtWXFWb3hJQXRZ?=
 =?utf-8?B?ZURoY3R3eHp0bFc0WDF6aTRLZTFKQ2F5WWVCUkRkQ2NJYWNrQzNsY2p1emNy?=
 =?utf-8?B?TkJRNWJUYXNLZTNCSkVSOUhOUnZCNkdBOXlJVHhwV3cxMnEzcWovSExnUWNN?=
 =?utf-8?B?YmgwS08zSjdTRlhleExsSk4vMHRnZkRmWGcvTkZRRGJtNTRxSjNUb1N2bnZK?=
 =?utf-8?B?S0hLbEd2dlFhQnhldTl5c2pTTThGQkppU1paNHljcUwyZVM1Mit5a0pLK2lB?=
 =?utf-8?B?VENMV0IwQzBBNzFDZW9VVzNKK05JMVE4a3RVVGM2dy9WaHY1eVhyMElDRmlW?=
 =?utf-8?B?U1hldHZtWEwvekYyVWRpb0pYS29ORU8zUllLWnBCV0FzK0JiZ1NtNnNUcVZn?=
 =?utf-8?B?aTZZeE9uZCt0YzljeDRScTQ3bTdVd2JDdVF6a1MxTmRzQmJyRzVFUDh5TDJX?=
 =?utf-8?B?SS9oME0rV0sxSkpHVlVTL2srY3VKL2J2L3d4bjh3RTFEdTd6UFZ1cU1nak85?=
 =?utf-8?B?cE1jckVNd3hzN3V5K1F6bHphbzVBMlJPK0MwV1VaSFVNVWdCaHpNbHY0OGY2?=
 =?utf-8?B?VXRWM3ZmNGU0Ri96MGZyaC96QUkzeFZNQ09USWpzRDJjcUVkQlVVTFdEVFlT?=
 =?utf-8?B?clF6amt4VVVHanhSaGVuMGZyeFRrY2xwSFFmdzNiUWVwNWdaZHl1SS9VS2xx?=
 =?utf-8?B?c2F4SnljN3VqRFIydUFaalhSckVIWFRtbldsdDdiZXlZUmpnTGRXOEJCeGhJ?=
 =?utf-8?B?NnQ4UlpuWWJyQlNMZDljRVNqYUowVjkzYlpxZVFWSVpjZ0FHTDJLSUJ3Mk83?=
 =?utf-8?Q?l928=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbffe40-275c-4663-5147-08dd3af48937
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 14:53:30.4609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNtfGupyNv7UVHrlUNiMwVyOAaZ8MQcL5iaSxNxXU7iopIrEotBa4HCDbe3RlLDqMaoC5Xfvy9IqWD8Nrf5eZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3201

SGkgTWFyYywNCg0KPiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjog
TWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IERpZW5z
dGFnLCAyMS4gSmFudWFyIDIwMjUgMTA6MzINCj4gQW46IEpvbmFzIE1hcmsgKEJULUZTL0VORzEt
TXVlKSA8bWFyay5qb25hc0BkZS5ib3NjaC5jb20+DQo+IENjOiBsaW51eC1jYW5Admdlci5rZXJu
ZWwub3JnOyBTdHJlaWRsIEh1YmVydCAoQlQtRlMvRU5HMS1NdWUpDQo+IDxIdWJlcnQuU3RyZWlk
bEBkZS5ib3NjaC5jb20+DQo+IEJldHJlZmY6IFJlOiBBVzogW2Nhbi11dGlsc11bUEFUQ0ggMi8z
XSBjYW5idXNsb2FkOiBzdXBwb3J0IGJ1c2xvYWQNCj4gc3RhdGlzdGljDQo+IA0KPiBPbiAyMS4w
MS4yMDI1IDA3OjUxOjUwLCBKb25hcyBNYXJrIChCVC1GUy9FTkcxLU11ZSkgd3JvdGU6DQo+ID4g
PiBIYWQgdG8gbWFrZSB0aGlzIGEgInN0YXRpYyIgZnVuY3Rpb24sIG90aGVyd2lzZSBpdCBmYWls
cyB0byBsaW5rLg0KPiA+ID4gU29tZSBzaW5nZWQvdW5zaWduZWQgY2hhbmdlcyB3ZXJlIGFsc28g
bmVlZGVkLiBDYW4geW91IGNoZWNrIGlmDQo+IHRoaXMNCj4gPiA+IHN0aWxsIHdvcmtzIGZvciB5
b3U6DQo+ID4gPg0KPiA+ID4gfCBodHRwczovL2dpdGh1Yi5jb20vbGludXgtY2FuL2Nhbi11dGls
cy9wdWxsLzU3MQ0KPiA+ID4NCj4gPiA+IFNvIGZhciBjb21waWxlIHRlc3RlZCBvbmx5Lg0KDQpX
ZSBjb21waWxlZCBhbmQgdGVzdGVkIHRoZSBjb2RlIGZyb20gaHR0cHM6Ly9naXRodWIuY29tL21h
cmNrbGVpbmVidWRkZS9jYW4tdXRpbHMvdHJlZS9jYW5nZW4tY2FuYnVzbG9hZC4gSXQgd29ya3Mg
YXMgZXhwZWN0ZWQuIFRoYW5rIHlvdSBmb3IgdGhlIGZpeGVzLg0KDQo+ID4gVGhhbmsgeW91IGZv
ciB5b3VyIGZlZWRiYWNrLiBXZSdsbCBoYXZlIGEgbG9vayBpdCBieSB0aGUgZW5kIG9mIHRoZQ0K
PiB3ZWVrLg0KPiA+DQo+ID4gV2UgY29tcGlsZWQgYW5kIHRlc3RlZCB3aXRoIFVidW50dSAyMi4w
NCBvbiBhbWQ2NCAoc3RhbmRhcmQgUEMpLg0KPiBUaGF0DQo+ID4gaXMsIHdlIHVzZWQgZ2NjIDEx
LjQgYW5kIGxkIChiaW51dGlscykgMi4zOC4gRm9yIHVzIGl0IGxpbmtlZA0KPiA+IGZsYXdsZXNz
bHkgYW5kIGNvbXBpbGVkIHdpdGhvdXQgd2FybmluZ3MuIFdoaWNoIHZlcnNpb24gb2YgZ2NjIGFu
ZA0KPiBsZA0KPiA+IGRpZCB5b3UgdXNlPw0KPiANCj4gSXQgYmFzaWNhbGx5IGZhaWxzIG9uIGFs
bCBvZiBvdXIgQ0kgcGxhZm9ybXMgKHVidW50dSBhbmQgZGViaWFuKToNCj4gDQo+IHwgaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LWNhbi9jYW4tDQo+IHV0aWxzL2FjdGlvbnMvcnVucy8xMjg3MjQ2
NTUwNS9qb2IvMzUNCj4gfCA4ODc5OTYxOTANCg0KV2Ugbm93IHVuZGVyc3Rvb2Qgd2hhdCB0aGUg
cHJvYmxlbSB3YXM6IFdlIG9ubHkgY29tcGlsZWQgdXNpbmcgZ2NjIGJ1dCB0aGUgcHJvamVjdCBz
dXBwb3J0cyBnY2MgYW5kIGNsYW5nLiBTbyB3ZSBtaXNzZWQgdGhlIGNsYW5nIHByb2JsZW1zIHdl
IGludHJvZHVjZWQuIE5leHQgdGltZSB3ZSdsbCB1c2UgdGhlIHByb2plY3QncyBHaXRIdWIgYWN0
aW9ucyB0byB2YWxpZGF0ZSBvdXIgY29kZS4NCg0KQ2hlZXJzLA0KTWFyaw0KDQo=

