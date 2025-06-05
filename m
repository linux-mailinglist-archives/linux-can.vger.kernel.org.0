Return-Path: <linux-can+bounces-3780-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17400ACED42
	for <lists+linux-can@lfdr.de>; Thu,  5 Jun 2025 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66FA1632A2
	for <lists+linux-can@lfdr.de>; Thu,  5 Jun 2025 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC8A206F27;
	Thu,  5 Jun 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hms-networks.com header.i=@hms-networks.com header.b="tksmbdFm"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021123.outbound.protection.outlook.com [40.107.130.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD11B9831
	for <linux-can@vger.kernel.org>; Thu,  5 Jun 2025 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117784; cv=fail; b=jJYoRcBVjxAd6V2ULBExYBA6DoLYtQLdbfxJKySIbDix0tMgrHgkysHDsg7BPmtDJRYnMtNyx6SbOSlNzcEEtZRJ8sWkiT2NwIHmim73fdRK7ghe2hMahYmmmuCHxfbdKCNCPURGA9v2LY96e89I/cYreEtPlv5Eaelnbdz2aRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117784; c=relaxed/simple;
	bh=WindLc57mpthYBQr4L2s0XSqmTWDXB9gn2L1beA/ps4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8hCjRkYPnB4q82588LtXaZbmj3WetdgZMK1xwdQ40CFJ/asFlERMBpqBXoN//9lFbO9KsDGC0gdaF+cynJdOkhO84uEieiVvf5ta1N7aeS9MhTbG7OuFIgb8++t5du5pbObAPFR/bwnNvwm3vKPSXhKljrU5Odo5cH/8n4iuI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hms-networks.com; spf=pass smtp.mailfrom=hms-networks.com; dkim=pass (2048-bit key) header.d=hms-networks.com header.i=@hms-networks.com header.b=tksmbdFm; arc=fail smtp.client-ip=40.107.130.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hms-networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hms-networks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdsqNXeyt9fEPPzgLA8D8+DAwz8ZjsgZtn+ygOqFASBlhObavlTZZrIIlUEvpWTTSvafmxoAUi15JekNFIRrPEiqSXm3PVPRiq0bh2vS8+4tGKEeshc17GtzqwwEDjhTPkhsN7IQQkMrF34KokLEJB0LljFALJIHCuezD8GnNYPiQ6jtfGey1WcJTvN7RCNdayJ/LhW7YHSRJLX5tHrfy2EoGOtGdusFGo7KW2Xw9yT0zOrvOG7zMHKFCE5Y7V2luwdKHcYMsb74XivlrQoeMJ9e4iK8X/iUCsIG5Qr97LRL611cpxctzsTY6ZqWCDse68Fld9zCuHBUz/e4fhMTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WindLc57mpthYBQr4L2s0XSqmTWDXB9gn2L1beA/ps4=;
 b=aDAs9HTSGnHKa+cvvR66XuEyr5fpmkrT/qS8O7e9g6inTRUzH2t2BnRMcWlVEvMJrBJTQ7GlgrlXMSJEMN2yf/WMGFa/2+Lpu7sOCJDyiDwRk00HdrRJ+KKroLZ8m2D+ymKTqNvHLABZAxwdDLofoJvslh8NxnGQyYUz3LLVn2inV86YLC8tg4FF5i4+d6nBk/S7xxOWfCaLnmadlVcCKubJBclXEb2TVIvVPGKd+ba/IaizaeYoEFUhfIr4OKvikxrL9Q6IgcYwJWLFjkvAeLRWun3F9dPRN3jNGGMWPOhUcYe+gl5WZDkD0pMF42mM3cAWyu2jWvVK5g6lUUmnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.com; dmarc=pass action=none
 header.from=hms-networks.com; dkim=pass header.d=hms-networks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WindLc57mpthYBQr4L2s0XSqmTWDXB9gn2L1beA/ps4=;
 b=tksmbdFmJgEUdnurxAE5m9Mho3celtvk/qCYFAIDWaNzdt7UN/S/L9Oylm/T2s7XZC8VO8jmhT/fdfwV1cwCxyUlrCtpyDcEuHc0rXwR+kWw4fVE/xSbrmWTZVH+xc7yV5uwdOcIHxw6LNaL53685qyIVh+1EoBnEggOknLLP8bYfmXohwVKxLfN0bhFMJ/qiIpeD1+Wyp7YBET9fl8eBDWDZKcUNkcpfAQ0/b7LiEYfjkakmn5Ho+zBdTPY5UY0N5ww8DlGJAuacUFHvervavT2IG9+Mr+H2+XTd3p8bl58JFsel1JvtNC40NcTP3Ceh5Mtb3VuoMahKgNwt+OvPQ==
Received: from DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cd::16)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 10:02:57 +0000
Received: from DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac8a:512d:4cd7:1bb6]) by DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac8a:512d:4cd7:1bb6%3]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 10:02:57 +0000
From: =?Windows-1252?Q?St=E9phane_Grosjean?=
	<stephane.grosjean@hms-networks.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL
Thread-Topic: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL
Thread-Index: AQHbz6T3UHfo4SMCp0qA1TMli15IbLPnqvAwgAvV4QCAANGcoQ==
Date: Thu, 5 Jun 2025 10:02:56 +0000
Message-ID:
 <DBAPR10MB4187723379DAAEE390253778D46FA@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DBAPR10MB4187FB44B12BD9DB8B992256D4832@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <06bd3b3f-2665-4f19-b13d-581e57f54dfc@hartkopp.net>
 <AM9PR10MB4184729E14AD5C05ABC65718D496A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
 <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
 <DBAPR10MB418777613B630B9F72E20008D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <28e79f1a-e80e-41c7-b076-9407ff431aa7@hartkopp.net>
In-Reply-To: <28e79f1a-e80e-41c7-b076-9407ff431aa7@hartkopp.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR10MB4187:EE_|PAWPR10MB7769:EE_
x-ms-office365-filtering-correlation-id: a2ed6b17-119d-4998-e6c2-08dda4182560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?3Y3TnSGTCNqHuYmto4don0hQFYNnWrcLyrxIkePC/te3XWJKq0/AE/aE?=
 =?Windows-1252?Q?pRsLpqIv0LqD/48J2sPFh/PWeTqOj3yzIO19Zz8VKlwqm7EPQkEyqXk7?=
 =?Windows-1252?Q?0U9eqJ+VSw2POUcMSWsD4onaQ92NHULWCSSlDcIAo9GkjFOarEEmyvzR?=
 =?Windows-1252?Q?p1m936g3doNvAnJmfkJRRdeayfMg/zxbNGZFuIS1XAos3rEadS83rQLN?=
 =?Windows-1252?Q?Lt8obawBxv5RvNZXsTMlNZw6MKkD7pf0n+DhLRtVSJQlDlGUIFvr+BJU?=
 =?Windows-1252?Q?yGHajw9Qg+AcO8UyVE7UYBLuPzt14b7HlRmmQz0VAVg2wSJ/Yu5KjFsb?=
 =?Windows-1252?Q?SQO0ajtGWrQ7wESKYZNl581Uc5/7gwQfUGCRQo5rYuOMJw2pcIfIxC3o?=
 =?Windows-1252?Q?ISHWHzvcfztsffG93F0TpnA8BIhD+lLMqYxw959+tXv0ZJK24XP5H7Ql?=
 =?Windows-1252?Q?Kd0Wr78fT138XWnL/TcWxQ00UFylen9a1xA5dvsdy7vijG8WYJCOgVJy?=
 =?Windows-1252?Q?6KACrBHs11MZz43CtuPZI0OpdiF9h/6fdFggsk/4aCaRrP2WOnrQzzYw?=
 =?Windows-1252?Q?yqY1MK+92AHqVPIl0gBLE7R3YWD1aX6vtixUVl+WXBGxeEkWXt/FGIBv?=
 =?Windows-1252?Q?YHl4uvhHGgQD2Kz0ssaNu9aGkus0gcT0jVHr7BG6YNHVCmi5HzMGnY6o?=
 =?Windows-1252?Q?lWuR8dKBLhpmNNCNglUIJM3eNSSrUchKL2Wr86Pcc6uOmEoOe08LQSyH?=
 =?Windows-1252?Q?MkXm4Yn75JI0wRwUng/XmXLN2VvduL8eJDdPvoHvwoda6gzh6IBoHmpB?=
 =?Windows-1252?Q?xPmrxhmdC6r7JKAQiyOeupFfwsaUczn9ifNuFglWIelQFcqcE/GeaaRe?=
 =?Windows-1252?Q?0+mXnM9IA/7ycyYS+RHmBOw19ZcDMfadNc942wtLTr69pHHK15gX2iBe?=
 =?Windows-1252?Q?SQ4WAjktGfbaYVuj9+2ZVB7EIppK9wFa39r5OZJaNp78T/nzuU+ocdh0?=
 =?Windows-1252?Q?laVs3wRQKWAzYeHjunTJdcb5ou9Xp5W8akIHreCWd6ze6NT/LsOaPOPd?=
 =?Windows-1252?Q?Jn8RDcTukTjZrG5FKD9WNWgqWv8R3wN5FN8OCxU+4XASctmMIcSnnF4g?=
 =?Windows-1252?Q?z6tPeiXhF8hBaKBWxTRkn43seoOSbAxEFzYIvdl3eO895GwD1A+lc1LD?=
 =?Windows-1252?Q?8I9QB4/kR9ITL2J44bpATRSH1t/mK19O6HLQfTl+ylUrkbmqijpj6XVW?=
 =?Windows-1252?Q?6obvUJmyS5UVUSUUxT0Ql8NRiePHtUN0xSGey//l11IOy6AWC9AfxY12?=
 =?Windows-1252?Q?Um4cP0RSW+oUeT0mam10B5CtyswuOU7Eqmr8BakfiG4oGiE+4vlpeGZB?=
 =?Windows-1252?Q?6mM9Q08/3mt7EEKPJi0c5YYTeiuLAKkogbR5+Ih4PIhsB9o4clhyk9t6?=
 =?Windows-1252?Q?oB0fmBo6r1LYvGr0SIyOwGT44tkTPQgmrSI1W3kt+s5cn3wrX5W5Tw2d?=
 =?Windows-1252?Q?O5t347pTgs1AP/cr0Ho1t7x/QKOvRrjESQ2bk0kySvh+oRKrQL8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Q+9ykPcNLN7MgLU2ve0cD3q/rrG5gAQM5+yX3aStCnKirieDDLnky3kn?=
 =?Windows-1252?Q?XQGg9spRaUxAmTogPaZD4ZmQ0gEZ6e7Af02NfVv4z7plnsrwhOc8GOdi?=
 =?Windows-1252?Q?6rg7X/aFe+FCi5Drq01POTMNwt3OhIq7b5VMUcEPBRQu1XIwb6IRitWj?=
 =?Windows-1252?Q?Wu6UnRUrrm9mLk6BIDb4v1YF/FifK0NkfgxRhjpSBFKZzk+2Rqz3Ygym?=
 =?Windows-1252?Q?9wtG9Wz7uV8NHA4ZHiY2AHqDuSIo5uiaXlRX4eLiV6OWble/rXYk7Mam?=
 =?Windows-1252?Q?qERMyYM928Z5DaAjZZeEMj3Vn6CvMUMuYnSxohos8VB83SgKb4BLMdIl?=
 =?Windows-1252?Q?nB5pVKrme8tMzSKFUPoGfiyKdcEBz4ruulsRmQDt+ACLmreRwzkW0PLB?=
 =?Windows-1252?Q?5jhEABGOBPh6LN8HQvCukfyAOQRRppl/TfgfPh/PAoK7sw6B1DB+AeJ2?=
 =?Windows-1252?Q?Ya7gqQynlTEPMRqvToEDK4KYYSpX1a6FPyJvztOfy6dULlvC5OoL2j48?=
 =?Windows-1252?Q?y6LOFG4XOaBLFh3wJVcrhEAAUBSy/yceeR9YbC8JZfDJ3tRuScSJJxv+?=
 =?Windows-1252?Q?yV+iBd4q8PV1w1ZjhUd/smyWkgaGNjvcoZm59BGR6WJuQQ/MdCgAT5TC?=
 =?Windows-1252?Q?ZtuWNjVQCP0Alu8xokn4rbajqCLicPUTy4SZtnxRm3p9jKHoThFzsTqH?=
 =?Windows-1252?Q?Mrcnmf58FbH3UWgo2E6KWa+JdEu8v/dXnB9b9JxG4VeQZ6m6+SedAXBa?=
 =?Windows-1252?Q?0W1tU+DR/1NZ3j4ATrOhPKtWngsPMXQCqAM8nmgel3f+I8+HEe1Sxa3O?=
 =?Windows-1252?Q?9m2He/BNY/89EaW7ZuU9e1RZedqsOGgy9lTaG2VS066GZHuaL0wbAHK5?=
 =?Windows-1252?Q?zT/Wyc/8s5CKUgZbrZA9lfMDejaudBswjciq4UWTavSDOdEUyimSE/lF?=
 =?Windows-1252?Q?7Infq2S4ILEqkBVID4KpezSs9G6D5kOhpMlik+ezvjSV+1FcHBOAEPzX?=
 =?Windows-1252?Q?3Ff0bUJ1RoV2N6cRWYwoQHsoH6C6AHKJGAyf9lUyW1ldic6ZFt1WFZ7s?=
 =?Windows-1252?Q?VxnFQ4kfGPcvc4FIG354/CuMx0QvQN1WkOMbz25wOoyXHpTVLrPAyW1J?=
 =?Windows-1252?Q?k5uc7VzEPo0XXDAUGkU5vP8xEgGAUskAXB0CFnHb6mxfYGIgoLuis37O?=
 =?Windows-1252?Q?t8UWot/RcEUMMJvbgYwn90jNAX8jXRUBtNKOQAza8VblUchWCQwgm+Nz?=
 =?Windows-1252?Q?J0xzorFncrClhORhvrmOYrEOYNzQ3M1ESuemq50viweveoLzfGF5Oi09?=
 =?Windows-1252?Q?JZMjgTvw3ev+H5eNn4BqT+XI4kBNIqzC9+yipnmJUA2kIN+VySMqKwD4?=
 =?Windows-1252?Q?R/edqBStxAfOZOcFRzTYDbJGN2uVTDJq0lwqmFTe55rKeNkuBvlxtZdy?=
 =?Windows-1252?Q?QjvZEqyiG8czynxJN3Hz2wpuWxZsQhGgECigv0oqbNjA+iKfAa7rfryN?=
 =?Windows-1252?Q?tdorV3OHeeSprrIYiP1QWEQW778cA0DBvn3YOEx0FPJReGUC8kieYFXG?=
 =?Windows-1252?Q?X94pDsZKGXFElJdFRDO0VGqHqwHQlexChcdABhz82jvOrzSvFeFaDSLU?=
 =?Windows-1252?Q?KOJbvacCz+tmczAcqETyEUnPaGgC85ubKqx109TK1QqWIZvvYQGX87cZ?=
 =?Windows-1252?Q?2dbjj7gENOsdf0x7lXbE0qnYwQAlGi1mXDibpvEU11hHjpXZUgcfKgdL?=
 =?Windows-1252?Q?fy8d5ynzlItrGi6MEvw=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ed6b17-119d-4998-e6c2-08dda4182560
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 10:02:56.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLnnTUe5i0DoXMQnLzUTl+3TyhO3sMkPPPIUwyACzJtrxzSCxAcyS+gwqtXURrGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769

Hello Oliver,=0A=
=0A=
My point was not to claim a 1:1 relationship between (CTRLMODE_FD,CTRL_MODE=
_XL) and (FDOE,XLOE).=0A=
=0A=
But to assume that:=0A=
=0A=
CTRLMODE_XL =3D> FDOE=3D1+XLOE=3D1+XLTR=3D0+EFDI=3D1 ("Operating in XL fram=
e format only"...)=0A=
CTRLMODE_XL|CTRLMODE_FD =3D> FDOE=3D1+XLOE=3D1+XLTR=3D0+EFDI=3D0 ("Operatin=
g in all frame formats, without XL transceiver....")=0A=
=0A=
and so on:=0A=
=0A=
CTRLMODE_XL|CAN_CTRLMODE_XL_TRX =3D> FDOE=3D1+XLOE=3D1+XLTR=3D1+EFDI=3D1 ("=
Operating in XL frame format only, enabling XL transceiver...")=0A=
=0A=
> There is a CAN XL only mode without CAN XL TRX switching.=0A=
> And this combination allows error signalling or not.=0A=
=0A=
I'm sorry but I don't find this combination. But perhaps we don't understan=
d each other on the term =93CAN XL only mode=94. Can you give me the FDOE,X=
LOE,XLTR,EFDI corresponding values please?=0A=
=0A=
Best regards,=0A=
=0A=
St=E9phane=0A=
=0A=
________________________________________=0A=
De :=A0Oliver Hartkopp <socketcan@hartkopp.net>=0A=
Envoy=E9 :=A0mercredi 4 juin 2025 22:34=0A=
=C0 :=A0St=E9phane Grosjean <stephane.grosjean@hms-networks.com>; Vincent M=
ailhol <mailhol.vincent@wanadoo.fr>; Marc Kleine-Budde <mkl@pengutronix.de>=
=0A=
Cc=A0:=A0linux-can@vger.kernel.org <linux-can@vger.kernel.org>=0A=
Objet :=A0Re: TR: can: canxl: about CAN_CTRLMODE_XL_ERR_SIGNAL=0A=
=A0=0A=
Hi St=E9phane!=0A=
=0A=
On 28.05.25 09:51, St=E9phane Grosjean wrote:=0A=
> Hi,=0A=
>=0A=
> refs:=0A=
> [1] https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/=
20220825_can_xl_vs_10base-t1s_v2.pdf=0A=
> [2] https://github.com/hartkopp/canxl-nl/blob/main/linux/0009-can-canxl-s=
upport-CAN-XL-error-signalling-switching.patch=0A=
> [3] https://github.com/hartkopp/canxl-nl/blob/main/linux/0011-can-add-CAN=
-XL-dummy-driver-DO-NOT-MERGE.patch=0A=
>=0A=
> According to [1] on page 6, the mixed-CANXL mode (island 1) allows joint =
operation (aka CAN bus sharing) of CANFD and CANXL devices. This mode requi=
res activation of the so-called =93error signaling=94 mode.=0A=
>=0A=
> Still according to [1] on page 6, the pure-CANXL mode (island 2) enables =
exclusive operation of CANXL devices on the same bus and is obtained by dis=
abling the =93error signaling=94 mode.=0A=
>=0A=
> According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL f=
lags are not mutually exclusive, so why introduce CAN_CTRLMODE_XL_ERR_SIGNA=
L [2] when the combinations of CAN_CTRLMODE_FD and CAN_CTRLMODE_XL would al=
low us to deduce this?=0A=
>=0A=
> Indeed:=0A=
>=0A=
> can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) =3D=3D=0A=
>=0A=
> CAN_CTRLMODE_FD=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CANFD mode (n/a)=
=0A=
=0A=
-> no CAN XL transceiver=0A=
CAN_CTRLMODE_XL =3D 0=0A=
CAN_CTRLMODE_FD =3D 1=0A=
CAN_CTRLMODE_XL_TRX =3D 0=0A=
CAN_CTRLMODE_XL_ERR_SIGNAL =3D 1 (fixed enabled)=0A=
=0A=
=0A=
> CAN_CTRLMODE_XL|CAN_CTRLMODE_FD =A0 =A0mixed-CANXL =3D> error_signaling=
=3DON=0A=
=0A=
-> no CAN XL transceiver=0A=
CAN_CTRLMODE_XL =3D 1=0A=
CAN_CTRLMODE_FD =3D 1=0A=
CAN_CTRLMODE_XL_TRX =3D 0=0A=
CAN_CTRLMODE_XL_ERR_SIGNAL =3D 1 (fixed enabled)=0A=
=0A=
=A0> CAN_CTRLMODE_XL=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pure-CANXL =3D>=
 error_signaling=3DOFF=0A=
=0A=
-> this is correct with enabled CAN XL transceiver=0A=
CAN_CTRLMODE_XL =3D 1=0A=
CAN_CTRLMODE_FD =3D 0=0A=
CAN_CTRLMODE_XL_TRX =3D 1=0A=
CAN_CTRLMODE_XL_ERR_SIGNAL =3D 0 (fixed disabled)=0A=
=0A=
But this is not complete IMO.=0A=
=0A=
If you look at page 270 in=0A=
https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v35=
0.pdf=0A=
=0A=
There is a CAN XL only mode without CAN XL TRX switching.=0A=
And this combination allows error signalling or not.=0A=
=0A=
So for our API this would look like this:=0A=
CAN_CTRLMODE_XL =3D 1=0A=
CAN_CTRLMODE_FD =3D 0=0A=
CAN_CTRLMODE_XL_TRX =3D 0=0A=
CAN_CTRLMODE_XL_ERR_SIGNAL =3D variable (default =3D 1 =3D=3D enabled ?!?)=
=0A=
=0A=
The fact that this mode has FDOE and XLOE set in the X_CAN controllers=0A=
register seems to be misleading in comparison to our=0A=
CAN_CTRLMODE_[FD|XL] handling. There is no 1:1 mapping.=0A=
=0A=
Therefore I think CAN_CTRLMODE_XL_ERR_SIGNAL is still needed for CAN XL=0A=
only mode without a CAN XL transceiver.=0A=
=0A=
Maybe we should rename CAN_CTRLMODE_XL_ERR_SIGNAL to=0A=
CAN_CTRLMODE_ERR_SIGNAL so that this mode is always visible for=0A=
information purposes for all modes.=0A=
=0A=
And it is only changeable for CAN XL only mode without a CAN XL transceiver=
.=0A=
=0A=
Best regards,=0A=
Oliver=0A=
=0A=
=0A=

