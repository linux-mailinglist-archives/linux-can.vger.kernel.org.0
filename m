Return-Path: <linux-can+bounces-3250-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4898A745FC
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6E17C0A0
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9221147B;
	Fri, 28 Mar 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IXVrdgJu"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0E17BA3;
	Fri, 28 Mar 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152855; cv=fail; b=QQsZrtN6BnM3g0GYbvtH1WW5EG1mVPObLuRPHwDOkoQb0DDgE4IbKNvhY05IAUmkBj/tRgz8fMQtTeSGNzFSXzCl9I4uQnw6WRU1CxqfQRoe45pFiJvL6OEpK8WZM+IJzL70vROw1diiviLbBBZYTmQddSQyuPqyxCgPI+kT1uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152855; c=relaxed/simple;
	bh=uZ0QxC6rBr2tDGFdmbJrUsSppAqM6dHaVoqWcjhP1uA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j8OuWEsHkaGTJpgDJ/isVt188Rh+wom7eWx6PQcqFzKtZKg8ehH0F3j03cJ/RiC9SyG39XPFqWT3U2Fupm0XFXmGRRrLoVvWD7TGc613XFRKFHJ0m4no+VKIoWGh+k09TAjFwgrsK30bPQrxSqvMD9pePgfdXw+93eU2whfqEcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IXVrdgJu; arc=fail smtp.client-ip=40.107.74.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK/RCo50ObbNacyJdTCLnzcEm1LzpeJ3nNOT6o5ANF9jd6Ua8Qz71zqtdyJnhd1b/gcMUhaoh4q305P70t9nz4wRDQhyM9HdBSVYAn3JiyhW0Y1TjPZRCewD7yUmnp8y0IX6XUgeGcH2AIb7jjnA689N17fDdyFjR65DO7c+TbGTZT9Yj426fbPCRxVocZJA2emVIbKm8KS/L60lWj3t6BFos1upEB9uPDFHQhgwjReqN0zUjVv8HdNUZpGo7WpvdWtK+XbmzpOfS5vuPVbxgSgt5rXAWsXpr3mwneh2QUqKuujXllNi1JNCS6fQ3+PPJ7Y+L3oHCPvU2I/z+oUa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ0QxC6rBr2tDGFdmbJrUsSppAqM6dHaVoqWcjhP1uA=;
 b=MMp5rVzfyjun126hOJymHQ+cwlqdawoh7jF3F7EPwFOUibbCLDXQGF0t7TEfz9+LuhLafKInNOgHgZYBIiZeKjjEjvniuaH9PJ/1kWzp4ke1mMEkILYz2h5inxBgslEPyqXbIsH787TVhJaT6Pb+t/WNt8JOFY2xpFSlCQWEGWQ68DhgvNTjs1zG/OtDRB6D0FQ4By/oi5juUfN2qxRrXsFr5vtQ7mTQuxYA4Cr0Gshn6206mQStFmbq0YgZdLs8ocdrass/od6CTNorL6PzYXi/++VdG3sQgrwk/LLZV7cXnLnSSIa6izCBazknb+ijwo0h+Wjfg9MdpVtN2vfm+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ0QxC6rBr2tDGFdmbJrUsSppAqM6dHaVoqWcjhP1uA=;
 b=IXVrdgJuK/b9+y8GUNmz22XCXqvUUKG96VK1gij9GChiL114oZug+dWsVOTijuHNuwIMV78CXkechmTM1y4vsySAZQQdey0F/hcSI8Ql89IS4GAlu0WD3eAxqJ8COjZ4x3P9pT/FbLoeWr9UNCJvdBf0MQGA+Lh7CIQlHUCc4Ao=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OS3PR01MB5925.jpnprd01.prod.outlook.com (2603:1096:604:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 09:07:30 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 09:07:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 04/18] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC
 macro
Thread-Topic: [PATCH v7 04/18] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC
 macro
Thread-Index: AQHbnkl4fNGnUGcaSk6ahnzsnbfIEbOIQWuAgAAAgVCAAAJGAIAAAGbw
Date: Fri, 28 Mar 2025 09:07:29 +0000
Message-ID:
 <TYCPR01MB11332F77F57859EF458B3C6C086A02@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-5-biju.das.jz@bp.renesas.com>
 <7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr>
 <TYCPR01MB11332F02DC51A974450A676B486A02@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <d282c214-20fb-407c-8af5-6b2b9298c877@wanadoo.fr>
In-Reply-To: <d282c214-20fb-407c-8af5-6b2b9298c877@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OS3PR01MB5925:EE_
x-ms-office365-filtering-correlation-id: 46879e77-cbc6-4d20-9462-08dd6dd7f7c5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3psN0xPdEdySkZyZ2VCR2NiZkJEYmViSmRHV0g1OGZpVExyaFFCVC9PeTBt?=
 =?utf-8?B?QmNYTkM0YUdWeEk1WGRTWFNaVUlrMlA1VlEzdFR6UVNNNTJFS29hRzVISG5l?=
 =?utf-8?B?YStpUm80NXFIS0JYMUNneUxzWVFLRjh2T3M4dlNkQ0tPdDJ3Ny9aSk1kTzE0?=
 =?utf-8?B?cmVNSVVLV09JTUxUOHJPKzFFcVhlV01Nb2tiRFVhN3Iva0xLZWdUeXRzVmJn?=
 =?utf-8?B?a01HY21rRzJTZUVuZGhwM1JmMkl5QktSeTk4WEQvNnV3YWI2UUIwTHZJZGYx?=
 =?utf-8?B?MFhEVzNCSXVaSGlibjNaOUlBa01mRW51d3crUG52Z25BZEJNR2VoNWRvbTJJ?=
 =?utf-8?B?ZXpYU1o1S1JKN2hOWlgxTDE1dXppZnZMYW5sMjVDY3pjZU5TNXI1U2V2SkJX?=
 =?utf-8?B?TEgyK0VTaHlZV0hSbnR2QlJrNUVBcElhcitUTHVEWGdUTzhxWDdaVFZtbU5V?=
 =?utf-8?B?RGM5MFIrcWMvTC9SMXVpVDdseVNCZlRXUjJZZkpiMG1uSC84UzNUemUzMzVj?=
 =?utf-8?B?V1lsQU1JVVdEV2dad1NkV1dHT0RYNEl1SCsvYWx0c2UyZEo4M1FEVE1yNjhP?=
 =?utf-8?B?Z3hMVklscmR1TjE0bno5N2c1R2Q5WEFmOFowQUZRdkp6VE1zZVArYkNPbm5U?=
 =?utf-8?B?RkQwKythbUQ0bE5KSE5DSmc1WThHYVZONldsZDFtb1lvaUxzNmk3RlJqMnNR?=
 =?utf-8?B?aW5QMlIxUEpPcnZ5MUVSYitaTkVvL1ZDVXd6ZXFlSmpxUnJWMGlCZTR6ekdK?=
 =?utf-8?B?N2JRQ3Q5TjJqVGNDaWFHTkp0ejh1L0I4eFRoUThoQjNmSkZVWEVpQ2htRGRp?=
 =?utf-8?B?bDJ4ejc1ZjJ6ekt1WndkazBkYm4zQk4wTTYwc0JZeWFuVUJzbHBjS3dFZ2dM?=
 =?utf-8?B?WCt0d2UzTjdqMjhSWXNHN3RqdzJxRkg5Sk9PeGYrSnV4cHNENVVldG9ucThq?=
 =?utf-8?B?U2Q0NG5yejlmeDJhcGhuR0JmOGk5R0Z4U2p1TXdXdmJrYW1NRWlPbnUvS2N4?=
 =?utf-8?B?V2tBci9nNFArUzE0SE8wNEkwRzQvMnZYWDRmRE9odnZQSHdNbjJNc3hxQ0pJ?=
 =?utf-8?B?d1FXVzJoZElZQjJ3bWY1U2pTRlV1c2M4czFHZ3Bqc3hDL21MaFJxYVlNMW92?=
 =?utf-8?B?N0ZXUHJETll6U1VBWEsvdnF3MkhZcEZycVEydldybHZvdDVvam16Z2t2QzZn?=
 =?utf-8?B?MVF6ZVBQdTZtYjQ3TE03ZlBVOVVYaEdxcFBQT1dvN29KUzJORmVWRkNPelhm?=
 =?utf-8?B?Vm5VRXFTbU9PMkhwY0VoNTRFNVI1OGxKOWxlWnk1cVRSdlJSMU9aSVZlRmVG?=
 =?utf-8?B?RkZkSnJ3a0ppb3Q3TktYdU5tcWNSeGlsUi9PaVdNTHhwMXVOZFdnc3ZIQ3ha?=
 =?utf-8?B?WXNXUHREQmZnbEptNFJJUEdyb012M0ZFeENRNXh1V1BOVTNWQjlzcXl1UXdD?=
 =?utf-8?B?NEcwdThqcWowVllzc0JnSnM0d1FpOFFPaW5PU2tNRndLbWRrK0dJVHFYNzg2?=
 =?utf-8?B?NERUdUtiK1hvSFJ3aks5RHUrVDBVeW95N29HNkFlT01oODFuVTFZdTNTMnJJ?=
 =?utf-8?B?R0I4QXErQmVJSmJOLzZKemNCSkcrdnJpVHJBUmd5bFBEM3pzWG5Gc1UrWFMy?=
 =?utf-8?B?WjE5dVpxVU5DMDBjc2FUcDNuWXBIVHJYS2JwZ3MrVWVPb1dWLzh5M2lVaU5u?=
 =?utf-8?B?R1FPWkt3K2k1aXJhSVZmQmtjOHEwbmFGRFFVNGNTY2JzZ29jT3owRkdKOW5P?=
 =?utf-8?B?NGdHV3pjOGtXcXZMd2lqbUhvMDJUbVFuY3MyUFdxelRKS05RVmswT3llK1R5?=
 =?utf-8?B?SU5QNG9LczdSVGYxSkMwQTBCa0RINzlCUUVQeDJReW5xS1M2S1lNSEk0d1k4?=
 =?utf-8?Q?gv2q/OgxgQRVS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0liaGhsay9ML3Fyd0ZTdG9VSjZKaU10Z1pqcExRMmJ1NnhFajhDOUdRYkdt?=
 =?utf-8?B?dncwZXl2YWdTSElZYU9Qb2t2U1Ura0tvbVh4MksyWmc5T2RrK29nVnp4Z25n?=
 =?utf-8?B?ZDNMWG5mL3o3SkRoMUd0YzVwaUxBS3E1RFFjN29vNTFuVmQxSkRrT2J1Qy9y?=
 =?utf-8?B?R1JCNmVBUWJFS1A4Rm9GejJXalpwMHBWeEk5Q3B2ZG52bEQ2RHJxbUI3elZV?=
 =?utf-8?B?clpZSzE2YVFaZ2RCR01XNU5KK2hOMDhCTTJEczN5TU5kendJTy9hdCtLUWNH?=
 =?utf-8?B?aXB3U0h5S3haU2k3OWdUaFVlMUlnVVBUd3JFSWxGN3RSVklGRkZjVWE3MWE4?=
 =?utf-8?B?WGdPaTUrc3JMNzVyT0J4amxCMDNIdDhESjZRSHIvU204WnlmN25NNmxMc05M?=
 =?utf-8?B?Q1RFVEpSa0EzMHk5WGplZTF2NmxGbXhlc2dZOW42Z2swUEh0NnlMeUJCb1dh?=
 =?utf-8?B?T2V1OU1IYmVSR0laTklVak02cXpkVWJDZGZpWS9TWHFIQ3VEUGRnRUJQVGVJ?=
 =?utf-8?B?ZWFaT2JLOEtPY0hqenpQRitnRTdjNlkvOTVBWVRkcENYTng3eEw3UWc3S2Na?=
 =?utf-8?B?bEw4SEdMRm9pUHdZakliSGRtVzRSN3lIdFBkT0xSUUFQelhXMXNIRFMvb3dm?=
 =?utf-8?B?djRTWHhNR2t5VEZ5bGhqNGdCcjcwcDE5ZWxmcmw4dXA0NEUvK1B5QW1VdXE5?=
 =?utf-8?B?WU1PRytEbjlTQ045NEk4RkFzZnVaMDcveGVxY1V6ZHI2clc1K2VqS3BONCtD?=
 =?utf-8?B?UWdkcnpRTEh5K0dScDdUM3k3ZW9CdWpNYjY4RGFlWkNyNkhnSkJLZmJmZ3h0?=
 =?utf-8?B?R1hrM2piYWNtZEljU1VsdFBtNkgwR241bmFNWDlEOXg3N3A5T1dsSGNxdFp0?=
 =?utf-8?B?Z0krWWNqWDZZcEp6bHB2SmhwYWpoZjdybXZtT1Njd0pXcTRRSmx4c1AxaUUr?=
 =?utf-8?B?WGk3Y2NQUURscjN6dlRqeEU3Q3RQSEkvYjkxNWk3WWpBNEhpNHVFU2tQWUxT?=
 =?utf-8?B?b3dHcS9XUmNDb3FYOEY4bzRrTEdkN0hTeWM2ZHRjRDkyTGNSSFpidVZOSFAy?=
 =?utf-8?B?d2FzWjQ2bVo2eDVsMytwaThZYUEwekltVFNPV2dHbGhESTlrMHRRT1FLYzNV?=
 =?utf-8?B?dThYUUVsSkhuMFBKcEIxdENZVCtkZlBId1dtRFFmaWQ1dmgzQ1FhTDBIZlo5?=
 =?utf-8?B?d2tKVG1hbGN6eGJlWm1oajUwTW1iREpzSlFPTVk0a0NYMTM4QS9LN1NiZ3gv?=
 =?utf-8?B?bUNWa2NmMG13U0pxWjFmQjM1QnFOVlN1UjJuQUFDWUhEVThrWlBWU01Mbmkv?=
 =?utf-8?B?QXdKMS96WmpjaVRac3l4d2c4dFlhenFYb1JwTnZhc3EzUkxVNUxUbmRCQnNF?=
 =?utf-8?B?L3RhRzM3dDBDeVZzaFZRNzJ2VVUvNE5YR0xtR1QrZGE2TWpZOWlVdmtyWVhJ?=
 =?utf-8?B?VnNaNWhvRHBCbHR3NzVGanNsVjFCMlQ4Z0JiS2xRZWJrSlZqeHVvMzdzaDBz?=
 =?utf-8?B?aUR5NC8xY0tYdEtSNDdvL3lYSngwejE3Q001SzdSOFJCcnlrODNSRkJHMXJY?=
 =?utf-8?B?OEtJbWZWb0JacVFBendGRHlwMERvMWtuVUoyRHlHbG1UU0xsSDRKVUZQQXdV?=
 =?utf-8?B?eENKOGt3Yk5LRjR0eVB5anJWbWVRMTJvNGdBNmJGbStvQ2lYVFZURldNck5k?=
 =?utf-8?B?RHM4TTlPWDVYZEVnQU04SlliazhZYTA4YnB1aGN6cTJMeHIyR0ZIZ0pWK0cy?=
 =?utf-8?B?aFZKQjhlTlJNdjcwL3RvaUxnUHp6UjJGUS81NGc3ODhmOHBTcWc2RUR6alhO?=
 =?utf-8?B?OW5yUDJseGlFTndTSjkwNWtpL1QzN1M0YVo4MnZvSmlxcXJiQmVFaDd0TlRy?=
 =?utf-8?B?WVYvT25JeWhWNy8ycWVHSU9qTGN5SGtrdGFHeEtYM0FhT2VQRkZmWGpNTWhu?=
 =?utf-8?B?TFdOQXpWK2JtLytsdjNBYmtsQjVZR3FXWDg3eE5DeHkyRkVRaFRGM205eDBa?=
 =?utf-8?B?eVo4MGNmbUZOZ1pENjRKY215Sit5K1EvMksyeDZ0N3RvRlJ0a0RLVGlBaDhK?=
 =?utf-8?B?R0x3YWphaWdlaXFYUFBLaWY0ZGRUTWFxMVczN2dLNUpKMm5MZmQvbXF4ajFs?=
 =?utf-8?B?amc1YTBTdzUxZ2VtZmY2bXFFdFlDN2dJWHBiYUFVeUNhVzgwdWwvWGpCZ1Yx?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46879e77-cbc6-4d20-9462-08dd6dd7f7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 09:07:29.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxhhXQgM+vIiObpMdF7eMcKmVR8rYBKybbU3nNX9LMyYHAP7ctLNldea1GtnNF3qId+khynMXzMdphOb65k/+xve5LBPfVoPUzRo9wOwHUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5925

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDA5OjA0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDQvMThdIGNhbjogcmNhcl9j
YW5mZDogRHJvcCBSQ0FORkRfR0FGTENGR19HRVRSTkMgbWFjcm8NCj4gDQo+IE9uIDI4LzAzLzIw
MjUgYXQgMTg6MDIsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhpIFZpbmNlbnQsDQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxt
YWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gPj4gU2VudDogMjggTWFyY2ggMjAyNSAwODo1
NA0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDA0LzE4XSBjYW46IHJjYXJfY2FuZmQ6IERy
b3ANCj4gPj4gUkNBTkZEX0dBRkxDRkdfR0VUUk5DIG1hY3JvDQo+ID4+DQo+ID4+IE9uIDI2LzAz
LzIwMjUgYXQgMjE6MTksIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4gRHJvcCB0aGUgdW51c2VkIG1h
Y3JvIFJDQU5GRF9HQUZMQ0ZHX0dFVFJOQy4NCj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1ieTogR2Vl
cnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPj4+IFNpZ25lZC1v
ZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+IC0tLQ0K
PiA+Pj4gdjYtPnY3Og0KPiA+Pj4gICogTm8gY2hhbmdlLg0KPiA+Pj4gdjUtPnY2Og0KPiA+Pj4g
ICogQ29sbGVjdGVkIHRhZy4NCj4gPj4+IHY1Og0KPiA+Pj4gICogTmV3IHBhdGNoDQo+ID4+PiAt
LS0NCj4gPj4+ICBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMgfCA0IC0tLS0NCj4g
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4+PiBiL2RyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+Pj4gaW5kZXggMmQ5NTY5ZmQwZTBiLi41NjVh
OTFjMmNhODMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2Nh
bmZkLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+
Pj4gQEAgLTk0LDEwICs5NCw2IEBADQo+ID4+PiAgCSgoKHgpICYgcmVnX2dlbjQoZ3ByaXYsIDB4
MWZmLCAweGZmKSkgPDwgXA0KPiA+Pj4gIAkgKHJlZ19nZW40KGdwcml2LCAxNiwgMjQpIC0gKChu
KSAmIDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2LCA4KSkpDQo+ID4+Pg0KPiA+Pj4gLSNkZWZpbmUg
UkNBTkZEX0dBRkxDRkdfR0VUUk5DKGdwcml2LCBuLCB4KSBcDQo+ID4+PiAtCSgoKHgpID4+IChy
ZWdfZ2VuNChncHJpdiwgMTYsIDI0KSAtICgobikgJiAxKSAqIHJlZ19nZW40KGdwcml2LCAxNiwg
OCkpKSAmIFwNCj4gPj4+IC0JIHJlZ19nZW40KGdwcml2LCAweDFmZiwgMHhmZikpDQo+ID4+PiAt
DQo+ID4+PiAgLyogUlNDRkRuQ0ZER0FGTEVDVFIgLyBSU0NGRG5HQUZMRUNUUiAqLw0KPiA+Pj4g
ICNkZWZpbmUgUkNBTkZEX0dBRkxFQ1RSX0FGTERBRQkJQklUKDgpDQo+ID4+PiAgI2RlZmluZSBS
Q0FORkRfR0FGTEVDVFJfQUZMUE4oZ3ByaXYsIHgpCSgoeCkgJiByZWdfZ2VuNChncHJpdiwgMHg3
ZiwgMHgxZikpDQo+ID4+DQo+ID4+DQo+ID4+IEl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlcmUgYXJl
IGEgdG9uIG9mIHVudXNlZCBtYWNybyBpbiB0aGlzIG1vZHVsZToNCj4gPj4NCj4gPj4gV2h5IGFy
ZSB5b3UgcmVtb3ZpbmcganVzdCBSQ0FORkRfR0FGTENGR19HRVRSTkMgYW4gbm90IHRoZSBvdGhl
cnM/DQo+ID4NCj4gPiBUaGlzIG1hY3JvIGdvdCBzbGlwcGVkIHdoaWxlIGFkZGluZyB0aGUgZml4
IFsxXSwNCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vd2ViLmdpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQNCj4gPiAvY29tbWl0Lz9oPXY2
LjE0JmlkPTFkYmEwYTM3NjQ0ZWQzMDIyNTU4MTY1YmJiNWNiOWJkYTU0MGVhZjcNCj4gPg0KPiA+
IENhbiBJIHNlbmQgc2VwYXJhdGUgcGF0Y2gganVzdCBmb3IgZHJvcHBpbmcgYWxsIHVudXNlZCBt
YWNyb3MgbGlzdGVkDQo+ID4gYmVsb3cgYnkgYWRkaW5nIGRlcGVuZGVuY3kgdG8gdGhpcyBzZXJp
ZXM/DQo+ID4NCj4gPiBPcg0KPiA+DQo+ID4gWW91IHJlY29tbWVuZCB2OCwgYnkgdXBkYXRpbmcg
dGhpcyBwYXRjaCBmb3IgcmVtb3ZpbmcgYWxsIHVudXNlZCBtYWNyb3M/DQo+IA0KPiBZb3VyIHNl
cmllcyBpcyBhbHJlYWR5IHF1aXRlIGxvbmcuIEkgYW0gdG90YWxseSBPSyBpZiB0aGlzIGlzIGRv
bmUgc2VwYXJhdGVseS4NCg0KVGhhbmtzLiBJIHdpbGwgc2VuZCBzZXBhcmF0ZSBwYXRjaCBmb3Ig
dGhpcy4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IA0KPiBSZXZpZXdlZC1ieTogVmluY2VudCBNYWls
aG9sIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gDQo+ICguLi4pDQo+IA0KPiBZb3Vy
cyBzaW5jZXJlbHksDQo+IFZpbmNlbnQgTWFpbGhvbA0KDQo=

