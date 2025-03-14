Return-Path: <linux-can+bounces-3061-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67795A60DBE
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 10:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA71723B6
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE841D5CC4;
	Fri, 14 Mar 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVLpZERm"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1141EEA36;
	Fri, 14 Mar 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945692; cv=fail; b=egB5kcCsGHAk2Ybwnrox/zjI2u24nbgbMoPd3RwRTWp2NFTiCKXDd/Ijlj7o3syGyrkBkG6s0GyFLtCtACJaNQ+QPR/c5tbZc1w5vOUWqllrA1pcn9EWtSZ6Gnbii85tiHb6mfSVX+Q8gUEofN7NAnSqFh2eS0hyQgyce3Mt554=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945692; c=relaxed/simple;
	bh=lZ30xHBjU60edI0Wj8KRHsddbKxi2g5y6D6uxUiBuWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sAdTVI+n5W9URWVDgu4xkFlsybBHxjAmEHAC2J5Ft/emHu+vhpuxzSuydNZVYXmwvUKMYPYiJY6j8jUxlKQg0W3V7713ECgORgXVBYOa2xziACK2emoZZ+Ib/7JbU7PpBIcTwTDJqMKgcJW0s6Ip5pQoGn2zhcoeftopEVcnkLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GVLpZERm; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qff9nIetpk/zhKaM1LnR1CiqDHoBqN3NTnzmn1LGniwPRhgILpBW5qfqxSKlJb8MNDbDiPNlITLhoAftpUUIjSrynYAANyeRvohXdqdYtYdGSl6bHW8U1zJcVcJBOtnYd1RA0VXI0lOpwWOXDzxnzv0D7ThNHDHjgWxAwactZkkoI/yNThCQuaypJ1iED+tgODRurGCQgjI805otWPIRuDpbq42cjEPSiwEn1KGPYDr+2cG2kY6FtXmMX1AjHPxFLkrMIaHui4oZHZSizxBWiWV/febaJzL3+QkutgI/CqA8OQtTOsVH4LDCsykR1ZNB0zNhtup5bKpPl9RFC5rU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ30xHBjU60edI0Wj8KRHsddbKxi2g5y6D6uxUiBuWM=;
 b=yj5xf1PSgInBEQOwKpUy+nNHejSCFP1WN8+GnMhA0S3QjZjvlSdt3rlHn33Tz7HPi2hDuk7+dNd0HAlr/m9OzAf/cU8os9o2qyvyZsVVW68CLSWNcfW38lIEPy2yieQ8KDLe/ZhkjxgSr7szv+3SlsfnCIhVHmWeRYSMJn7QMzcIMOpTufR0rSCVMWi+5RaNk3jNdLZIyodFtrHFMJ+6brtveiAinI2oTDxisn5C12MJUJFbQT3H+gtRmkXC/F6Q5hOlFGTQPB/ux2hLq4XwO0Du8cgkwD161H0v1QRWdBmhNq0o9J3pAU261CSoQY2BbRxjS3UpNCS4TopPKEWcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ30xHBjU60edI0Wj8KRHsddbKxi2g5y6D6uxUiBuWM=;
 b=GVLpZERmedBu6HEeWwU7bzyIC8M66eftEQ4XHlRZvV7Bb8CYombfhA4diIIhYaUMiBoqQLpggjFskMKl6yhgOJDRxs0U0zJKn03KS/9Y9EqEzfEvbCxknHqY36wdgsUV8595wXKjDHiTWBLsMtHxWSoKxyF/uF+YfcMku2DdBJvKsBOSaOWTv5X/G2sXqjYQpXuGVtjzRBbw0DV1FoQc+rc431LzZCWKnLpRj7Q3w6KEIB76fGwH8Rf+71QFPnhlSWWp6CVt0kabDLOcFov5TWGaULA4/5Zb2aThhNYTrIxZI/uoXuB1+LlhBw7+E3tODzUepGcIKNBS141zBnSeJw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 09:48:07 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 09:48:07 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, "Ciprian Marian
 Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Han Xu <han.xu@nxp.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
Thread-Topic: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
Thread-Index: AQHbjmUm0iZo0n5nwU6W9vzwqR1syLNyZc8AgAAIU4CAAADPQA==
Date: Fri, 14 Mar 2025 09:48:06 +0000
Message-ID:
 <DU0PR04MB9496EC52CF54A8F635F1408690D22@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
 <20250314-invaluable-economic-caterpillar-80541a-mkl@pengutronix.de>
 <20250314-married-polar-elephant-b15594-mkl@pengutronix.de>
In-Reply-To: <20250314-married-polar-elephant-b15594-mkl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBBPR04MB7593:EE_
x-ms-office365-filtering-correlation-id: ba0d1c13-fa7d-4e79-984d-08dd62dd52a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0N5UEtmNGJmNFZ5MVJyZ1NoY3pyVU9PazZnb1E0YTJNeHBqQkJuU2E4b2Rv?=
 =?utf-8?B?SkpnZ1dmNHBnZGtFNHIwQkdjSjRnQVBCaVlxUVRMeUl1Mm9BZUVndTRQR3JB?=
 =?utf-8?B?UlZNYXVaVHRKcDBlT0hEWVl0Z2dkOGRrUlNQTTN1ZjIvNE0wbC9jTXcwT2ZX?=
 =?utf-8?B?aXpWKzREeHljTW1adlRMMGNYcnZzNzNZUkJtczZiQWY5OW9MYW11c2VwTjRz?=
 =?utf-8?B?aXZ6bjFoTzhaenpkQkJUQzlESnBOcUR0QXBXb01NWldoQkZHekhoZHMrT1Ft?=
 =?utf-8?B?TTcycTROa0V2UzBTQkRXbFNHVDY1WlBxWDhVWXAvRnVPQ1R1V3BDRmVPZ1Ay?=
 =?utf-8?B?eUFTVEk5UjIxQ3psZDIrSkRJTUQwSzFvemdvdXFiOC9GeDJVUUtZSVd0OWds?=
 =?utf-8?B?MGZtM3hOb3V6MTJ3Q24rYjZMRDJ1bk5YaEFEbHZvR2svd3ppNVVkZXB1dm9a?=
 =?utf-8?B?VVlBZ2FFeEViS3VEbkhLQkh2S3JSZE4vdGJDTFl1N0pQblo2bW5KQWcraDB6?=
 =?utf-8?B?ZGFHdHRyKzVGcDBIazNQRnU4QmVxVU5QNGVnWjdsL1lGQXlrSmRVRGZpQTgr?=
 =?utf-8?B?R0djeVhOZVJRSjQ5WERxYVlMOHcvMllieGtkQksyK3FuK2xTY2dIR2JYYUh3?=
 =?utf-8?B?VWZCRXVldDVVNXhGenZTV1JyaDJBSVgrUFY3OGlkQXFTWjZtbW5USmwvaDZ1?=
 =?utf-8?B?dnZqb3hwWHV1bDNlU2RCbUtNVzNJRlpLVUhPbTRtS0JIZzR0Nm5Sc3BSamtT?=
 =?utf-8?B?YkNaQzZRR1U3ZS9HdzNEQWVrVWM3SkZIZ2ZSUnN4clQ5K1ErUWtad0JoRjIz?=
 =?utf-8?B?UGxMeXlsaEwxejVvV01sd3RELzNzMWNIUTZpQm9nWXFxMHdiR2U1cUJvNW15?=
 =?utf-8?B?aFdnQ3k3OXNqODUzVHFZMFVuSFBPLzloYi9lMjBvRDF2dFBjR1VNZlQwTU1o?=
 =?utf-8?B?Vkp5L1p2TkhFc2lma1FFM0dId3ZpSmx2MmZDTGNiZ2lnd0g2MGNZaE1GMjVu?=
 =?utf-8?B?RUt3NU15aUlnbTF3Vi82cHMyWHluL0tTN3kvY0Q5Ti9hck5VMWYyNFFYSGo0?=
 =?utf-8?B?eEYxMFhIZU1xVTBleFdGWG9Iams3WTNJdVJid2dpMUFwclhROHNUbFhya29s?=
 =?utf-8?B?WExYSGc0NnZqU0hQa0I5YWpnSTlHSGxjSVowWlRVa0lzMUVza0VoWVJlVjMw?=
 =?utf-8?B?cWdHUUVzUlNha0x0YTMvYk0zb243dk9nZEFSZmdZQmcwY2JsY3QxRTlXOGdh?=
 =?utf-8?B?S0xucTN0VGcydXB2ZWc1QUl0emJMbUlyM2NiUTAydGNQZkhIZGx0VEs4dzlz?=
 =?utf-8?B?cHNMY3VvdjBQK3hmM1p0c1ZBTU5pcWRBZU1PRFVqWjBrUnNjNjhob0FtSXIx?=
 =?utf-8?B?QUpySTJqRjdzMldrZzM5WXh2MUVtRUFPckNxNDJERE4rTmZGT0lUZlZlOHB2?=
 =?utf-8?B?bVpZWXN1K0h1WVl3b0NHakFQK044eU5tNW00Z2RWVStwZHM4ZWpUV05PZ0h4?=
 =?utf-8?B?bWdVenZQZzBidEtjY1dqWGhUdm0xUzlUQWphbTdtNldoYk9YRk9BdG5zTXZN?=
 =?utf-8?B?dEdKRkxodHFtcWpYVHh6MXZBMFNsdzJYV3NkcmoxQUZqb0pUTjlGUHBrSTl0?=
 =?utf-8?B?QmJxRCttYVIxcGw4UStDVHMydFRuK2o3NXduemNtR2NSSUxra3FHV0FWQTNW?=
 =?utf-8?B?N3NXKzJ0TXBNU0JNSUYyUXltNFVIMjJ0dmpOM2M0cDZqelQ3WURTYWcybWpR?=
 =?utf-8?B?dE9KQU5YOGxCbzNqdWUwSFB5Y0wrWjVTcCt6TzBHMFJVWVpmWFhsYkhNNjdX?=
 =?utf-8?B?ZVZlM1R6WUVNQ1h4OUtJZk5DRThiV0cwalpRZTdsUnlvZ1p6cUFCZE8xNmVX?=
 =?utf-8?Q?Lbs35lmuD/bNK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVJXdkRQL0lYQ0FwUXhjTmdpQ05ueHdPOHZ6YTZSRlQvelM3SVF2bHdiWFIw?=
 =?utf-8?B?ejU3bmEydzNWR0x6NE9GT3FLWVBRbFR6eW5nY1NZTjcyRWdaUE05VVZmR1Az?=
 =?utf-8?B?SFpzNXUrL0xBY2RBbWhKeUg3ZEhPTWhwamJvRVM2VFZ1NlZWakdldEdETHZP?=
 =?utf-8?B?aUtndHZmcVhnaEo0dS9iUWIvTTg4dW51TGRNTDR0VjJlSGJNS0xrM0w2VE1L?=
 =?utf-8?B?Nk03b2ZkeHp1Z1N3dWsvblhNSmpxMjl3T3lXVVBrOENuUDlaeVlMTmw4aDBH?=
 =?utf-8?B?c09HK1pOWWE3VW8vS25zUmg0QStFNkZPVGZXVnFzZENNZTBwSUgvVFBubzQ5?=
 =?utf-8?B?TVoweVVYSkRleTBrUWU2ZnJ4Q21kSFhsb1JmbFZSNkF3bjNFWnRkeWUxS04z?=
 =?utf-8?B?NWpCdkpjenZEbGN2YU5DQnoyL09Ga2Fmd1ZBZk00RjF3cnRYUlVRZTV1ZEYv?=
 =?utf-8?B?bnlYRFYxampXdFduY2prbklIVHNCMno2MStad2VIb1g3cTJIY1YxRFIwVzF5?=
 =?utf-8?B?R1FNUGRDZVoxSVNIanhFejM4c3hEaXVmRzZQTEd0YUpvRWg5OWVSVUhWNGNT?=
 =?utf-8?B?ajZuNXVPV1pveFZYTnF2OThNN1NUT25SRmRnQ3FYc0x5OG5mVG5lNVNzbUx6?=
 =?utf-8?B?b1QyaU45bnFxdyt3Y2pPb2dXUHgyc2J4NzVhMTZaTEhqc3VPMDJBTUFYVkJN?=
 =?utf-8?B?ZTcxWXgxUlhKSUdzN094NnQ2MGw3bGpJOXJBUldZakhmK3ZCL3pUeHRzanEr?=
 =?utf-8?B?NHRjVDRVemZDT1BrRlR6NGRIMUVoSG0zSm9zam03OW13NnZQNDVaRUc0OHl2?=
 =?utf-8?B?QjZ3MlBadFRDWm50Y2ZGdFFIUVkrNFJabVVuRDRLaHhSWS90Tk9XSmZ1YkpJ?=
 =?utf-8?B?UmwxMzF1bXJWVForblYvdGVxV1lhdTIzbzlPeERHSFZUbThCbmlrWVdHdDNU?=
 =?utf-8?B?dWtMb1IrSmVGNHRnSzRuWGhRRVQ3UDVFT3RIcnZZVnBXd1FTVkVOdnNGMks2?=
 =?utf-8?B?QkI5eStUZyszUVZZY2V2VG9GOE44Vzd0anJLd2VEWUNKdnpOZFBPYS9BVzhp?=
 =?utf-8?B?V1V0SVNSMTZrbGlHWjh4N1NYcjc2RnJwck92bjRyRERITXdFNEFHOGFCbzJP?=
 =?utf-8?B?aEFGaW9Ta2VCdm5JcTJJbE9hTHFOMjkwa1VlelpuOFh5dmxRa3F4L255ejIy?=
 =?utf-8?B?dXZTOHAxZ1YrL2tmQStMSCtUdEhKNm5DQmVqY0hqYTF5VkdESnc5YVJaUGxa?=
 =?utf-8?B?TldWdTZkRDlBeDYwWG1iTHFxY0Z0TUJoWkpxcTRjMVN4OWVpKzFHamJVWllU?=
 =?utf-8?B?ZFVocjhFdEFwcGdET3c2Mll6RlhLQjg1K1Vrb3dubklLQ1g5U3g4WmpwNEJz?=
 =?utf-8?B?TnJ3dmZTQ2tFL1lvTUIxdkVaMWVzL3paN2lXWE5wazQ5QlpiYy84UUxBSURr?=
 =?utf-8?B?WVhycVRncGdoeGg2YjlUdm1TUThLQ3FGb1hiNDR2Y1dQUzZ5bFkrZTI2bEtx?=
 =?utf-8?B?ekRCbnJzY3drQlBQSUN4aStJaTNDaWRKOG9adWxGd2U0M2l2WDRGT2E1TFJr?=
 =?utf-8?B?N3RSYWtVbm80K051R2hldytFUU5hZTFxbExMZWE4RGNTZDlTTnFZVHVmQi9z?=
 =?utf-8?B?MUVOcGFOQTFRY2hpU1lMYTlnRWpVVURBQ0dLMmlFS0xTdit6ZFoxcmluVTVT?=
 =?utf-8?B?QW03VUJoeTl6cTBCZHp4MGhlbzlQRmN2Q1NabWZLMndtUmRKWitmckhqQy9B?=
 =?utf-8?B?YXVkZXV1NnF4OXZmRWxzM09tRnlsSEhTZHF1MlhEVWlLRzVUMzVjZWdmdk9J?=
 =?utf-8?B?bXpiczNua0NDSFVYM2QvTHhwN1pQc0UwMVJYSG1Va1I4VkhDR2M1YUdid0hG?=
 =?utf-8?B?dlFQUGZLc08vU3d5MXMvRnFFbXd4MmxGMSt1bEpSeHV5RFJjNFQ3QWR2Wk1p?=
 =?utf-8?B?cVdsQjNmcWk0N2dQbnp6aUMrSXFTVFNYRVJCbFA5ckZ6NVhiNEdFYTg2Y3Jz?=
 =?utf-8?B?WlVtWWJnNnBtd3VmUmFydHdGSzVrSnVzSkNqNGs2aUxWRDl6K0pDU2x4Kzcv?=
 =?utf-8?B?bGlSQjFwYk5jcHlDRGVaQ3M0anQrVzYyZ3kvQUJNQVNLTzRHNTRnb2JtY2li?=
 =?utf-8?Q?G8nw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0d1c13-fa7d-4e79-984d-08dd62dd52a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 09:48:07.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edk94uOtxsjwhmw9PatIqfwvnKU2bIZTndnKGK7TCd1nj5nBV0Kni0KmUlTQONgr6THSxPqIJ2PNOKxzO9gAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI15bm0M+aciDE05pelIDE3OjQzDQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcjsgQ2lwcmlhbiBNYXJpYW4gQ29zdGVhIChPU1MpDQo+IDxjaXByaWFubWFyaWFu
LmNvc3RlYUBvc3MubnhwLmNvbT47IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+Ow0KPiB1LmtsZWlu
ZS1rb2VuaWdAYmF5bGlicmUuY29tOyBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBjYW46IGZsZXhjYW46IG9ubHkgc2V0IENBTl9TVEFURV9FUlJPUl9B
Q1RJVkUNCj4gd2hlbiByZXN1bWUgaGFzIG5vIGlzc3VlDQo+IA0KPiBPbiAxNC4wMy4yMDI1IDEw
OjEzOjA4LCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gPiBPbiAwNi4wMy4yMDI1IDE0OjU5
OjIwLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gPiBGcm9tOiBIYWlibyBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gT25seSBzZXQgQ0FOIHN0YXRlIHRvIENB
Tl9TVEFURV9FUlJPUl9BQ1RJVkUgd2hlbiByZXN1bWUgcHJvY2VzcyBoYXMNCj4gPiA+IG5vIGlz
c3VlLCBvdGhlcndpc2Uga2VlcCBpbiBDQU5fU1RBVEVfU0xFRVBJTkcgYXMgc3VzcGVuZCBkaWQu
DQo+ID4NCj4gPiBXaGVuIGxvb2tpbmcgYXQgdGhlIGNvZGUsIGl0IG1ha2VzIG5vIHNlbnNlIHRv
IHNldCB0aGUgY2FuLnN0YXRlIHRvDQo+ID4gQ0FOX1NUQVRFX0VSUk9SX0FDVElWRSwgaWYgdGhl
IGRldmljZSBpc24ndCB1cC4NCj4gPg0KPiA+IFRoZSBzdXNwZW5kIGZ1bmN0aW9uIGRvZXNuJ3Qg
bG9vayBjb3JyZWN0LCBlaXRoZXIuIEknbGwgc2VuZCBhIHYzLg0KPiANCj4gQWZ0ZXIgYSBzdXNw
ZW5kL3Jlc3VtZSBjeWNsZSBvbiBhIGRvd24gaW50ZXJmYWNlLCBpdCB3aWxsIGNvbWUgdXAgYXMN
Cj4gRVJST1ItQUNUSVZFLg0KDQpTZWVtcyBvbmx5IG5lZWQgdG8gaGFuZGxlIHRoZSBwcml2LT5j
YW4uc3RhdGUgd2hlbiBuZXRpZl9ydW5uaW5nKGRldikgcmV0dXJuIHRydWUgaW4gUE0uDQoNClJl
Z2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IHwgJCBpcCAtZGV0YWlscyAtcyAtcyBhIHMgZGV2IGZs
ZXhjYW4wDQo+IHwgMzogZmxleGNhbjA6IDxOT0FSUCxFQ0hPPiBtdHUgMTYgcWRpc2MgcGZpZm9f
ZmFzdCBzdGF0ZSBET1dOIGdyb3VwIGRlZmF1bHQNCj4gcWxlbiAxMA0KPiB8ICAgICBsaW5rL2Nh
biAgcHJvbWlzY3VpdHkgMCBhbGxtdWx0aSAwIG1pbm10dSAwIG1heG10dSAwDQo+IHwgICAgIGNh
biBzdGF0ZSBTVE9QUEVEIChiZXJyLWNvdW50ZXIgdHggMCByeCAwKSByZXN0YXJ0LW1zIDEwMDAN
Cj4gfA0KPiB8ICQgc3VkbyBzeXN0ZW1jdGwgc3VzcGVuZA0KPiB8DQo+IHwgJCBpcCAtZGV0YWls
cyAtcyAtcyBhIHMgZGV2IGZsZXhjYW4wDQo+IHwgMzogZmxleGNhbjA6IDxOT0FSUCxFQ0hPPiBt
dHUgMTYgcWRpc2MgcGZpZm9fZmFzdCBzdGF0ZSBET1dOIGdyb3VwIGRlZmF1bHQNCj4gcWxlbiAx
MA0KPiB8ICAgICBsaW5rL2NhbiAgcHJvbWlzY3VpdHkgMCBhbGxtdWx0aSAwIG1pbm10dSAwIG1h
eG10dSAwDQo+IHwgICAgIGNhbiBzdGF0ZSBFUlJPUi1BQ1RJVkUgKGJlcnItY291bnRlciB0eCAw
IHJ4IDApIHJlc3RhcnQtbXMgMTAwMA0KPiANCj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0N
Cj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAg
ICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93
d3cucGVuZ3V0cm9uaXguZGUgfA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAg
fCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0s
IEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy05ICAgfA0K

