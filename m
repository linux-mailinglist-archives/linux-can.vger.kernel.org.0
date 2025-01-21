Return-Path: <linux-can+bounces-2669-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E2A178CC
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 08:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3FF18859FB
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1913D297;
	Tue, 21 Jan 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="FonN+qeo"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6F1B4139
	for <linux-can@vger.kernel.org>; Tue, 21 Jan 2025 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737445918; cv=fail; b=udW3YqVGiYV8VYAg/1r+dEnIHWt7lQawGrvU9sPgyARzSXkC2X1U/iOhiMXVCTrJVPyxoS/LJk5Os7h4Z5I1eiUhu49jCwx5+e3Wh+9reDH/MVKS3stMRhFUF9mlqO6hspX8MV8UXNCh4Q1d2kv7Y9rlPitR9fw/ijyD9qafu9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737445918; c=relaxed/simple;
	bh=4H0ch2X1K43MrVRlhMkFCUos48RzDLMBs9lqKWP5vWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C/8Koi7jEMecFGYl2AeJoOthMg19uy/ZY9z7ULlJb2HxHnPMnzls3jjCiDjgx7+XMAjf9SFDtmnrq8utXwiczRxvLkl0H8TqSIeS7xqSCLlMiqTGkkl/LINPMs72UwSMzUmsi1k7Db101H+1W9uKUcl07bEEgPRcYrv42eL1akA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=FonN+qeo; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqgZwvMieWqJItEtUT/9L+rAufYUNh1pQlB7tBDGw3Or+7LPB62AMibjyjWMohP7rrviMi4x5pi1UyfjadDn/0EDsS3E3oydrEcekgpQCxnFAb4vt5bmsLu74eXxLKHpR5G38KpGfPLUPt4AgYcT79WQ4WF/ZVCRBR9ycus252BlgyYZXWRMIzHLb0SEBGlSHqA72qQpr5OgD/0bwDQpMCX3QOT+rgQn68hrvJgLeQtdEKHhgvZV4HU2+cEuea48ReoYi3IOXWh9h3Nj7X8M2rfOY5cUg7XPk08Nz9ezx5jibcNfOWuN05nfrwaOtEVHKJAO0D3BVY83TBc7zuZKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H0ch2X1K43MrVRlhMkFCUos48RzDLMBs9lqKWP5vWg=;
 b=YEaJnoKGlPCd8XjRHnH3rlIQFe1jZGx9nCjl5C/IdYB6vnJ/6tRICJ81s6nH9nZ65PBvhux+jMTDzKTZjYSbNyJ/48oM+U5ISnnt3CxY8xkY20NucxowPHUWylhfa0xO6rS89cUjVWl2/pDArDc1VZY2bukgNBkL6DqMHQho8OqmtQeN2iPODUL4O80fZeUJsgaTNb+gTn7A7ei81ZR18UmLIq4JZjuAwuPje2dQOpHlLXy+vLLe1c469fVs77NEBnDbrxFyL5nOK/d5TyF0YVM4k5PmwIylXAw7BcOJ5wmZBV1UOwUdhFu0GuW675p6K1z/Lr8aUKp0iILDmuJuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H0ch2X1K43MrVRlhMkFCUos48RzDLMBs9lqKWP5vWg=;
 b=FonN+qeoYdj2iNwnsQTlo/PQ8c2w+nGNKSgk5jP/RKE1yabyESTemyzww4/zo4cL71J1Gtf7i/I0LiR63SehkmqCpUhrspFpMTPBHTnaRXfL1/xCX5772xl6YmreH/G6rYKSznEOecPiXLIVQ9WQblWsDHia38qadAPqT0hpx29Zm8oE9w7PxIPvQA6p0nhRUEcESpDjK1Pj35X6FiXyI54HWRz3oNape3OFtLyjVG0nZKPkBs9cPgpSn+fuB/WRc6mmCw5kiI+HG7VasKGirBvQXbDYUtHs4boxaU18QIEzsAJHPwmaDyWb3LWJULvfTSsUAxQzYAHtRSDsNTiTiw==
Received: from DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::12)
 by PA1PR10MB8586.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Tue, 21 Jan
 2025 07:51:50 +0000
Received: from DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::104a:4c1c:9bb3:3036]) by DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::104a:4c1c:9bb3:3036%4]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 07:51:50 +0000
From: "Jonas Mark (BT-FS/ENG1-Mue)" <mark.jonas@de.bosch.com>
To: "EXTERNAL Kleine-Budde Marc (Pengutronix, XC-CP/ECP2)"
	<mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Streidl Hubert
 (BT-FS/ENG1-Mue)" <Hubert.Streidl@de.bosch.com>, "Jonas Mark
 (BT-FS/ENG1-Mue)" <Mark.Jonas@de.bosch.com>
Subject: AW: [can-utils][PATCH 2/3] canbusload: support busload statistic
Thread-Topic: [can-utils][PATCH 2/3] canbusload: support busload statistic
Thread-Index: AQHba1e530xoAcc4TECHTmKzq4uTZLMf5eMAgADzSoA=
Date: Tue, 21 Jan 2025 07:51:50 +0000
Message-ID:
 <DU0PR10MB7076197E81AB49C6C59ECE60ADE62@DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM>
References: <20250120162332.19157-1-mark.jonas@de.bosch.com>
 <20250120162332.19157-2-mark.jonas@de.bosch.com>
 <20250120-vigorous-almond-toad-a28dc0-mkl@pengutronix.de>
In-Reply-To: <20250120-vigorous-almond-toad-a28dc0-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB7076:EE_|PA1PR10MB8586:EE_
x-ms-office365-filtering-correlation-id: d323287e-546e-4e64-9388-08dd39f076cf
x-ld-processed: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTR3aUd1QTdUM3FWbkFEWnY2WWpwMUYwOHlDOE4zbGFBZUhOR3BQOXhtekNP?=
 =?utf-8?B?Uis3SGVkVEg3akZmdmtUL2pDalp6UWlnT0J2WFpZQkhrSlkzS21teng1ZWpY?=
 =?utf-8?B?d2Q4blBZWTF0VElKUEt6enZxNWFrRUVEeGoxaHg0RXd3b253UHQ1MGFTcnFK?=
 =?utf-8?B?eVBZOWZURWZWYzhCclRJWGdSbzl6YWpBcC9HLzlScXlRRHlIY28yKy9xRnFk?=
 =?utf-8?B?T1h1VEFwSnQvbGNnWHVrWDA0Qzg1cW0xa3hHSktKR1lCTW9xb1RmVUtTT2ZP?=
 =?utf-8?B?ZWgxUmh6Rlk0eHM0bUoxWnZRZXQ3UkNFM2tDcFVPb3duSFFocDdiVTBIUEZm?=
 =?utf-8?B?S0pVek9va0UwRzNTTU1adThaRXhzcjBJRmhOd3dqUlkreG0vcmVZbUd4SVBo?=
 =?utf-8?B?akM1ZVcvWGFla1FMZGJvRXpaanA1MVRneDRBTno4RHpLUDc4NjBuWk14TW5T?=
 =?utf-8?B?MzR4and6bnJoSG4vcWVLb1A2Rm0xT0RLTjExRTE1MmZuNkhuOFp2V0dvc2NZ?=
 =?utf-8?B?bTBnTUZXUlM4SXI0T3FDa0ZDZWx6MW1yV1JYWnY3Y0I0ZTlDcDQyTjdHNlpP?=
 =?utf-8?B?SlFmK29QVm05ajFFUDNrNVFvVnUyWjJCTHM0RXZNc25acnpIc1NYVFVqTzdq?=
 =?utf-8?B?L0tMQ3ArYjFOU2dhcis1S21qMitWVW5HTWZ5Z29uckxpTHdhT0w5YnF0YWdX?=
 =?utf-8?B?QWEyZjZNRkxXZlNFTlozYm5lN1p0SWFLUitiaHVnclNRWFMwN0JrcXRUNFFz?=
 =?utf-8?B?ZWo4endPMkd2ZkZFbEVMVXgxRStSdFZKSUtUYVM3bVlRNm5qWTd2OFp2YU1o?=
 =?utf-8?B?K2tiREZ2QmVDa0xUaUlYZlVpWEozdXNJM2lqN1dtc3UxTGN5Ym1oTVJnNTRj?=
 =?utf-8?B?VXhkZDBJWkh1TXN3SE5JT3ZQdGtobFZoR2pOeHQ4YUx4WXJBWHhBbk9KcjBm?=
 =?utf-8?B?c2VuMURNZmRCdGFsZFVlTGRseEVsa3o2S1B6alZrdkR4bHdvTEE3Q1BiYkxk?=
 =?utf-8?B?a0JKVnNzNEhNWE9vVkx6OXRNVVRIRWl6c3Y5NHd2N0ZXcmg3K2ZoNlAvQVhp?=
 =?utf-8?B?YWJKeFJwZ2NXRnNjVVlVZ214aGcrdVYyLzI2clZldXBwaEl2Sy85ckpFWnFB?=
 =?utf-8?B?SW5sNUJwdldtSDlLeVppZ3I1UDFkOHA5N2o5anhIbEhkMitkaHVKNjRtUnMr?=
 =?utf-8?B?ODFxMXYwQlB5TUNKTHI4RHpHenpBU2ZiSEZaejl6Z0p1dlZ6RjczWVowNHNL?=
 =?utf-8?B?aTdnVEFnSTBkS25pOEJmdjN6bVo0UFhQdUNBUlRkNkFXMkRZRXNSQ1FlQlJ2?=
 =?utf-8?B?U29tSzlLWW52ck1FNzFtSFYxZDJqRlFHTXBBM1lRZEdHU1o4OERrY0xlMUZo?=
 =?utf-8?B?bjdCSTZVYUNKekluajlRQlhCbkNZME03WDhSQ1RQK1NaMk1Td21qeC9yUmtp?=
 =?utf-8?B?dW85ZldwTmhLL2dPWXdJM3YyOXc2ZTlETHYvTlRUMzc3USt1VGJxcjduL29R?=
 =?utf-8?B?RDkwSjV6L2lBSUhHM0hGdUhvWmhwcVdxbTJydm04ek5aN2pMU0Rud2d0WGNy?=
 =?utf-8?B?Ynl5NHBjOVVPZmoxQ3Q1QUgyQzFnTkNPVUR4L25tQi9RRXFQanBUWjFFMEt1?=
 =?utf-8?B?QVN3VXNmZVZ2eGNEMkNmSkdsSmQ1MW02eTFtV05nS004UzBnOHNNc1BaMm1o?=
 =?utf-8?B?dEN5WnU3WlRYSkovdXkyS0pZSzk5bGRzaE1MYWpyRWlwMXlocFpNZHVsZEpr?=
 =?utf-8?B?eDlwRDF4Qm9POFA1aWp0dXZTWWpSWUJPSUVRNzliZ09vTlpJWGRNWE93dTZT?=
 =?utf-8?B?cEZQVkNQYkE1bHpFSEU3ZVJDa1pIK3c4R0prMTQwZUtyMy92ejQ4QWZMSjkv?=
 =?utf-8?B?T2dyeTIveUNXTURBZ3FVTjhFbVc0WEJ4L0RaN0x3SjA2M3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDJvQXBKU0tiV1NTazVtMldOcDFEQWJtQlUybmtqVXA3OWd2elF3MjVSamQy?=
 =?utf-8?B?SXpCMldvR3dPcVF6M0xBY0VXNDVtSUxIV3o2RWYyS1ZsMlFDbzRWTmFPU2Rp?=
 =?utf-8?B?STh4Rm9vSjZ1dGRKMDVCSnpmNEk0NVN6TmNqbWs2VUlJL0lETDQ4di82K3U3?=
 =?utf-8?B?d2Y5bG1SSVZ6aTcvek1XRkVVN2xjUi9sU0krME1jZ3J1K3FMYXV1Z092NmVt?=
 =?utf-8?B?eW1GTHhpNHhTc1Y3KzRkSFoxZXdFV3hKRVJOWUphWWtZaHZvV3NsenZpbXJ4?=
 =?utf-8?B?RXR6bkJGY1lOYzA4ZDNWUU5rR2Jua2lIbmgzYnMyRHVxM1pxZ2p5V2wwMnlj?=
 =?utf-8?B?UHlnMWcrTFF6aWliQmluY1ErUzYzS3BYNE1CM01KY2JzYmlhdjhsU1JXalVD?=
 =?utf-8?B?eUt3cDhPQ3JISGJDK3d4R1VNTUt2ZjJlc3FJMWdISTlkaXM4eEV3LzJuSXhB?=
 =?utf-8?B?aDRlcnE1VzFhUDhpYlk1a2orNFJuZjRod1o2MFBmTXo3aUJLSG81bXV6Q3Vi?=
 =?utf-8?B?NTF3cEM4WUNGcWtTZ1U5eFdVdFpmeU9OdkdKY3A1NktXKzhDdElFWVN4L0g2?=
 =?utf-8?B?WjV1YjVnMWJ4RFVpOXFEd3NnelJCRytLZG83QmJIejhJR2M4QWxqZ2tmS1hX?=
 =?utf-8?B?WXNTQmkyTktLcFlTalJUSHhSMlFYQ0VIMEV3VlB4enIrOFlZc3JPWDN4V09v?=
 =?utf-8?B?a1dLNTluMzl3cVdTR2t0VXRkMVpybFd2YXY0eVg0MnFKQjBsM3VpNkova1VY?=
 =?utf-8?B?Njlzc0tqaWNtSzZlbkNZcDh3eXZsY1FIUGRtUHgzUEF6SEFxRVlFQndDRDdu?=
 =?utf-8?B?dmZUT2FVaDAwYmtGdFVIRWpPTUF0ZXFtbEtqV3JoWktMaGRBNzk1VERqTjMz?=
 =?utf-8?B?dmJNSjZIc3BjZFErREpSVkFHWnd3MTRaMWJyejZTVVhsRDdHbXFqeWFzMDBN?=
 =?utf-8?B?MkI4UWMvdGptUUhNZVhoekJSLzUwbVFENmY3QVdUb2FYV1hEZ3pjbUNQM3Ew?=
 =?utf-8?B?VTU3cHFrcmxaWFcrTENFcEVkeGl6NnBGazViVFlPVkR2cmFxYzZkbWNXOW8z?=
 =?utf-8?B?ZTZaSTlyeU5STDNXT0l3YzdRdldhaHk0N0d6amcrbk5EY05UUklHS1JUSnV3?=
 =?utf-8?B?R2JNSGJnbVJ4bE55ajZvZU1KdlB6YjZxcDMxaEhnWnhWNXpMQm5LRHkwRkNy?=
 =?utf-8?B?ZjJsQ2JQSW9ya3IwbnBkcVRZUjNXcVZ1S0NzQ2d2SUlkNTQ2YjdlTGdlUm0z?=
 =?utf-8?B?em94cldDLzZDK05GRkJpUEsyVElSR2ZlZ0ZpeDNtWW1DVXd0djBhSXZQQ1ZR?=
 =?utf-8?B?bld4cjE1aEgvOE1ScXBGSUdMYWxJRVZ3YzZzSGxNcGhrTjFEZFVEWjFkdFVz?=
 =?utf-8?B?TWR6L2M0ZVF2dDJ4RkJvWW5NeUtqM3lwZWlzOU1qOUtZd1YwOERobkh3S3pj?=
 =?utf-8?B?Mm5CR2kwVW1EQVAwVzV4ZWNiZy9ESXBOY3h3dXJJR2p0UXRSTlM2dktZSXdo?=
 =?utf-8?B?RnAxeDNJNjBnSGdqOElka2NKS3pMZEtMcjFJeGpRZkxTVXRzZi9WcE1PajFL?=
 =?utf-8?B?UTBIQWthZUNkNGVRdXl4eFh2ck9JR3ZhM0VHaDlNbU40NU9WcWVORHE1OEx6?=
 =?utf-8?B?YnJ5TGdpRTZ1cTNEblNqU25SRkg3cVhaWWNnVnpKZVhJSkt6TU8vMzdZMm45?=
 =?utf-8?B?M1FJZXNiUW4wUFFNOUFFdGRDcWhBM1Nsd3ozUVZnU2N4OW1Fdk5nSUdDbHNv?=
 =?utf-8?B?UjkvdDJuRHN2QmJRdEVyYy9LU0JFdnVZUGdlb1RSVXlYYXBka2VQRkZjUlUr?=
 =?utf-8?B?OVhnN3pBUzJGN2ttNk45WXhlYnJqL3R0cVhTbTlFTkJoNHFNajQyVkYxLzdM?=
 =?utf-8?B?L3RsUGZiZFA4OEFnTXdPUVdQQ1BqWEZKZWlWQzlPaTc2N1o3OXpDekp5TzVK?=
 =?utf-8?B?amYxSEpoR3RZQjJMUGZRVVAyT2hHUDlpL2dVYUhJZkRVbjNrTHlHSEFHbmtx?=
 =?utf-8?B?NGFoS1NxM1NBS0RKZ28zclhnVlZUTUhVZDhMSnJpV2hoYnU5WXFmek1XQzhv?=
 =?utf-8?B?SXl4bkN0ZHlEM2x5Tkp4MUQyNVI3Nk4zTkRQUUV6N3RFb0tSRXVRRmVKYU8x?=
 =?utf-8?Q?b4fA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d323287e-546e-4e64-9388-08dd39f076cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 07:51:50.4379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiKzpin03jnTamQD1f7VnOUZ5+EiucOn57Sc7ZAkZXMOFsgEag30Rlq1NbiFaOZk6FGSgVU0s9DLZcQMZ0Zetw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8586

SGkgTWFyYywNCg0KPiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjog
TWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IE1vbnRh
ZywgMjAuIEphbnVhciAyMDI1IDE4OjExDQo+IEFuOiBKb25hcyBNYXJrIChCVC1GUy9FTkcxLU11
ZSkgPG1hcmsuam9uYXNAZGUuYm9zY2guY29tPg0KPiBDYzogbGludXgtY2FuQHZnZXIua2VybmVs
Lm9yZzsgWmh1IFlpIDx5aS56aHU1QGNuLmJvc2NoLmNvbT47IFN0cmVpZGwNCj4gSHViZXJ0IChC
VC1GUy9FTkcxLU11ZSkgPGh1YmVydC5zdHJlaWRsQGRlLmJvc2NoLmNvbT4NCj4gQmV0cmVmZjog
UmU6IFtjYW4tdXRpbHNdW1BBVENIIDIvM10gY2FuYnVzbG9hZDogc3VwcG9ydCBidXNsb2FkDQo+
IHN0YXRpc3RpYw0KPiANCj4gT24gMjAuMDEuMjAyNSAxNzoyMzozMSwgbWFyay5qb25hc0BkZS5i
b3NjaC5jb20gd3JvdGU6DQo+ID4gRnJvbTogWmh1IFlpIDx5aS56aHU1QGNuLmJvc2NoLmNvbT4N
Cj4gPg0KPiA+IEFkZCAnLXMnIG9wdGlvbiBmb3IgZGlzcGxheSBidXNsb2FkIHN0YXRpc3RpYywg
dGhlIG91dHB1dCBjb250YWlucw0KPiA+IG1pbmltYWwsIG1heGltdW0gYW5kIGV4cG9uZW50aWFs
bHktZGFtcGVkIG1vdmluZyBzdW1zIG9mIG9uZSBzZWNvbmQNCj4gPiBhdmVyYWdlIChib3Jyb3dl
ZCBmcm9tIExpbnV4IGxvYWQgYXZlcmFnZSBhbGdvcml0aG0pIHNpbmNlIHN0YXJ0IG9yDQo+ID4g
cmVzZXQgKHByZXNzICdyJyB3aGlsZSBydW5uaW5nKS4NCj4gPg0KPiA+IGNhbmJ1c2xvYWQgMjAy
NC0wOS0yMyAxNzoxNToxOCAoZXhhY3QgYml0c3R1ZmZpbmcpDQo+ID4gIGNhbjBANTAwayAgIDk0
MiAgMTA3NTM1ICAgNjAxNjggICAgICAgMCAgMTglIG1pbjogIDAlLCBtYXg6IDIxJSwNCj4gbG9h
ZDogMTYlICAgNiUgICAyJSB8WFhYLi4uLi4uLi4uLi4uLi4uLi58DQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBaaHUgWWkgPHlpLnpodTVAY24uYm9zY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEh1YmVydCBTdHJlaWRsIDxodWJlcnQuc3RyZWlkbEBkZS5ib3NjaC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTWFyayBKb25hcyA8bWFyay5qb25hc0BkZS5ib3NjaC5jb20+DQo+ID4gLS0tDQo+
ID4gIGNhbmJ1c2xvYWQuYyB8IDkyDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOTEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NhbmJ1c2xvYWQuYyBi
L2NhbmJ1c2xvYWQuYyBpbmRleCA3NTNkNjU4Li41NzdkOTljDQo+IDEwMDY0NA0KPiA+IC0tLSBh
L2NhbmJ1c2xvYWQuYw0KPiA+ICsrKyBiL2NhbmJ1c2xvYWQuYw0KPiA+IEBAIC00OCwxMSArNDgs
MTMgQEANCj4gPiAgI2luY2x1ZGUgPHN0ZGlvLmg+DQo+ID4gICNpbmNsdWRlIDxzdGRsaWIuaD4N
Cj4gPiAgI2luY2x1ZGUgPHN0cmluZy5oPg0KPiA+ICsjaW5jbHVkZSA8dGVybWlvcy5oPg0KPiA+
ICAjaW5jbHVkZSA8dGltZS5oPg0KPiA+ICAjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ID4NCj4gPiAg
I2luY2x1ZGUgPG5ldC9pZi5oPg0KPiA+ICAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ID4gKyNp
bmNsdWRlIDxzeXMvcGFyYW0uaD4NCj4gPiAgI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4NCj4gPiAg
I2luY2x1ZGUgPHN5cy90aW1lLmg+DQo+ID4gICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCj4gPiBA
QCAtNzIsNiArNzQsMzQgQEANCj4gPiAgI2RlZmluZSBOVU1CQVIgKDEwMCAvIFBFUkNFTlRSRVMp
IC8qIG51bWJlciBvZiBiYXJncmFwaCBlbGVtZW50cyAqLw0KPiA+ICNkZWZpbmUgQlJTVFJMRU4g
MjANCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBJbnNwaXJlZCBmcm9tDQo+ID4gKyAqDQo+ID4NCj4g
K2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC90cg0KPiA+ICtlZS8NCj4gPiArICogaW5jbHVkZS9saW51eC9zY2hlZC9sb2Fk
YXZnLmgNCj4gPiArICoNCj4gPiArICogRm9sbG93aW5nIGFyZSB0aGUgZml4ZWQtcG9pbnQgbWF0
aCBjb25zdGFudHMgYW5kIHRoZQ0KPiA+ICtleHBvbmVudGlhbC1kYW1waW5nDQo+ID4gKyAqIGZh
Y3RvcnMgZm9yOg0KPiA+ICsgKiAgLSAxIHNhbXBsZXMvcyBpbiAxIG1pbnV0ZQ0KPiA+ICsgKiAg
LSAxIHNhbXBsZXMvcyBpbiA1IG1pbnV0ZXMNCj4gPiArICogIC0gMSBzYW1wbGVzL3MgaW4gMTUg
bWludXRlcw0KPiA+ICsgKiBpbiBmaXhlZC1wb2ludCByZXByZXNlbnRhdGlvbi4NCj4gPiArICov
DQo+ID4gKyNkZWZpbmUgRlBfU0hJRlQgMTIgICAgICAgICAgICAgIC8qIGJpdHMgb2YgcHJlY2lz
aW9uICovDQo+ID4gKyNkZWZpbmUgRlBfT05FICAgKDEgPDwgRlBfU0hJRlQpIC8qIDEuMCBmaXhl
ZC1wb2ludCByZXByZXNlbnRhdGlvbg0KPiAqLw0KPiA+ICsjZGVmaW5lIEVYUF8xICAgIDQwMjgg
ICAgICAgICAgICAvKiAoMSAvIGUgXiAoMSAvICA2MCkpICogRlBfT05FICovDQo+ID4gKyNkZWZp
bmUgRVhQXzUgICAgNDA4MiAgICAgICAgICAgIC8qICgxIC8gZSBeICgxIC8gMzAwKSkgKiBGUF9P
TkUgKi8NCj4gPiArI2RlZmluZSBFWFBfMTUgICA0MDkxICAgICAgICAgICAgLyogKDEgLyBlIF4g
KDEgLyA5MDApKSAqIEZQX09ORSAqLw0KPiA+ICsNCj4gPiAraW5saW5lIHVuc2lnbmVkIGludCBj
YWxjX2xvYWQodW5zaWduZWQgaW50IGxvYWRfZnAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCBleHBfZnAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGludCBzYW1wbGUpIHsNCj4gPiArCXVuc2lnbmVkIGludCBzYW1w
bGVfZnAgID0gc2FtcGxlIDw8IEZQX1NISUZUOw0KPiA+ICsJdW5zaWduZWQgaW50IGRhbXBlZF9z
dW0gPSAobG9hZF9mcCAqIGV4cF9mcCkgKw0KPiA+ICsJICAgICAgICAgICAgICAgICAgICAgICAg
ICAoc2FtcGxlX2ZwICogKEZQX09ORSAtIGV4cF9mcCkpOw0KPiA+ICsJcmV0dXJuIGRhbXBlZF9z
dW0gPj4gRlBfU0hJRlQ7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBIYWQgdG8gbWFrZSB0aGlzIGEg
InN0YXRpYyIgZnVuY3Rpb24sIG90aGVyd2lzZSBpdCBmYWlscyB0byBsaW5rLiBTb21lDQo+IHNp
bmdlZC91bnNpZ25lZCBjaGFuZ2VzIHdlcmUgYWxzbyBuZWVkZWQuIENhbiB5b3UgY2hlY2sgaWYg
dGhpcyBzdGlsbA0KPiB3b3JrcyBmb3IgeW91Og0KPiANCj4gfCBodHRwczovL2dpdGh1Yi5jb20v
bGludXgtY2FuL2Nhbi11dGlscy9wdWxsLzU3MQ0KPiANCj4gU28gZmFyIGNvbXBpbGUgdGVzdGVk
IG9ubHkuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gV2UnbGwgaGF2ZSBhIGxvb2sg
aXQgYnkgdGhlIGVuZCBvZiB0aGUgd2Vlay4NCg0KV2UgY29tcGlsZWQgYW5kIHRlc3RlZCB3aXRo
IFVidW50dSAyMi4wNCBvbiBhbWQ2NCAoc3RhbmRhcmQgUEMpLiBUaGF0IGlzLCB3ZSB1c2VkIGdj
YyAxMS40IGFuZCBsZCAoYmludXRpbHMpIDIuMzguIEZvciB1cyBpdCBsaW5rZWQgZmxhd2xlc3Ns
eSBhbmQgY29tcGlsZWQgd2l0aG91dCB3YXJuaW5ncy4gV2hpY2ggdmVyc2lvbiBvZiBnY2MgYW5k
IGxkIGRpZCB5b3UgdXNlPw0KDQpUaGFua3MsDQpNYXJrDQo=

