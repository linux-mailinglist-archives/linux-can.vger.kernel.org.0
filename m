Return-Path: <linux-can+bounces-1428-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B096FE2A
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2024 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA13B28744B
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890A15B125;
	Fri,  6 Sep 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="YoDLUJBZ"
X-Original-To: linux-can@vger.kernel.org
Received: from us3mail02.teledyne.com (us3mail02.teledyne.com [130.50.171.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633C15B0EC;
	Fri,  6 Sep 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=130.50.171.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663396; cv=fail; b=un6PsBI5HgI5xa797AkwX1cza4tgSiSmdHWhUfl213gXOEeuKQtHntVjxSd1Qqi4emydiZgT+PljDHrtBJHRf81UfXipNERNGsu6HhMqvpY52di9oQFZisn8YZkXm5ATYBNS76ryynHsWyVrrvX1qRHhUr1CYIDjWcg6kl5R5Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663396; c=relaxed/simple;
	bh=pNGpKZzegnExRiMD0UdvgyobqhyK7F4Q6zV/Z84Qs+4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hrvwwkkDCmId21jCCVryXKLuQSPqd7rRDkJgXfV6tzaT5uTjd2WjEfpOqtBZlPZUNeUHSbqWniA9bD+iV6EWijKT1zRM8Z/VrIfZGHxVgc0A4AO7BGiF3Y0/Cu8xbxzYwe6uiJWuL1g1dBJd/oMUV9qbir5A680jUe4zLsd+EQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=YoDLUJBZ; arc=fail smtp.client-ip=130.50.171.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1725663395; x=1757199395;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=pNGpKZzegnExRiMD0UdvgyobqhyK7F4Q6zV/Z84Qs+4=;
  b=YoDLUJBZSXMpws6USqYaaMjnEQnS6gQyZg46Nxs8R+MBSDfe/wSjf4Ui
   imcxcd/4fVA0egaszZZdxb0JHrkZ/YntDp4K3TZU6mnqXdLA7OlqQppeT
   Nk1CQM00UV44tMeOU1ri6LW6g2lK+IA6Fv2FxXb6jpQ6l55ZhI/xwE31b
   Ci+I64UFfZIbcYwpT9PLLAcq4NJjik9EO3F+IoOn6Ox7m5fEKRF9qg+lw
   UofH41tUnOymW/plcK0mVEY0/axPfhRUIEY+Sxc/cnIF/aOv9NQMB4FQ3
   lmRaa96YQlhKyQkMry6e1H6C2G9qFIFWA1mXKUqLWfTnDwum8nQXvScaC
   g==;
X-CSE-ConnectionGUID: GB6w/0O3STGrvUdHDSiWmA==
X-CSE-MsgGUID: mRHlnDX6Sq6rBdI8L4K9jA==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:R8SjsKMDT8C0DUXvrR3flsFynXyQoLVcMsEvi/4bfWQNrUoihmNTz
 mQXDDiDbqmDYGD2eYtxOYq09hsD7JCEmNRrHQZtpSBmQkwWlceUXt7xwmXYZnvIcpWbFBoPA
 +Y2M4GacJhsFie0SjOFaOWJQaxUjPnQLlbEILeZfH03HEk8FXpJZStLw4YRmpRvjcWyHzSDs
 Nbzp9y3EFK+0laYCEpNg06+gEgHUMra6WpwUmMWNagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nVKtio2nhc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuodcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw1cwpHiYW0
 qcjFB8XcC2Pp86NwY2+Y7w57igjBJGD0II3h0o6iA/hKM0JBLXpc/2Qo8NUzXEsi8RDEefYa
 owSbj8HgBboOkYXfApPTshiwaHz3xETcBUBwL6RjYg+4GWV7AV02qnFLNfRd9CbQ8gTlUGdz
 o7D1z2lX0BDZILDl1Jp9FqpvM/Lmw/LBrkLSqeS+t86pAGwl246XUh+uVyT5KPRZlSFc9ZeL
 VEEvyEnq4As+0GxCNrwRRu1pDiDpBF0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC6
 7OSt87yX3lxqLiORjeY/KfM93WuNTlTMWIGaCMVSwZD6N7myG0usi/yoh9YOPbdprXI9fvYm
 lhmcABWa20vsPM2
IronPort-HdrOrdr: A9a23:Q+SuRaEyOJDlc66dpLqFYJHXdLJyesId70hD6qkvc3Nom52j+/
 xGws536fatskdpZJhSo6H5BEDmewKVyXcV2/hZAV7MZniAhILFFuFfBOjZsnbd8k/Fh4hgPM
 5bGsAUYrOQMbETt7e+3ODSKadD/DDzytHNuQ6o9QYJcegFUdAC0y5JTiKgVmFmTghPApQ0UL
 CG4NBcmjamcXMLKuymG3gsRYH41pf2vaOjRSRDKw8s6QGIgz/twqX9CQKk0hAXVC4K6as+8F
 LCjxfy6syYwryGI17npiPuBqZt6ZXcI+h4dY2xYw8uW3XRYzOTFctcsnu5zXMISa+UmRQXeZ
 L30mwd1oxImgnslyeO0F/QMkDboUoTwm6nxlmCjXT5p8vlADo8FspanIpcNgDU8kw6obhHod
 Z2Nk+ixuhq5Cn77VHAzsmNUwsvmlu/oHIkn+JWh3tDUZEGYLsUqYAE5ktaHJoJASq/sekcYZ
 9TJdCZ4OwTfUKRbnjfsGUqyNuwXm4rFhPDRkQZoMSa3zVfgXg8xUoFw84UmGsG6fsGOu55zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIWh7IOHL6GyWVKEjGAQO8l3fa2sRF2AjxQu128HIbou
 W+bLvu31RCBn7TNQ==
X-Talos-CUID: 9a23:ibQhsWNYP4kcJ+5DdwM56wlMPZseTlLH0krcA2ODCFlsYejA
X-Talos-MUID: 9a23:ylcV3Ar1eXim2OX4HDcezzRYFMNuz5TwM1lTi78KmpmgaQ8hOR7I2Q==
Received: from us2-vpmsg-mbx02.tdy.teledyne.com ([130.50.245.31])
  by us3mail02.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 15:56:27 -0700
Received: from US2-VPMSG-MBX02.TDY.Teledyne.com (130.50.245.31) by
 US2-VPMSG-MBX02.TDY.Teledyne.com (130.50.245.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 15:56:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (130.50.245.239)
 by US2-VPMSG-MBX02.TDY.Teledyne.com (130.50.245.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 15:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBfJb29ZoThF1rp5+gaZQrJPWuDQ8JcjtKFb3PGJIzU2Er5ci69IdMZoRZzaNd/HAm8q2OPE20j+KCCY40oIV3ALrPKoZWd9No8sFskLeNf4eS+NbtNl1MHzjhf7bhNIDrbex7o443BP7EESktWfpEBpl/5CMuvLlA+gXAtdL8AskZOVd+6YS/LwzzC37PtaqOQN2WlsTrgj9HfZTv38xtNU8Xh1VOFkCn9AkvCV3TMgDK1q9IebIzzVO/GmYtz1edylQM/qjkxLUqwIodS0IvxqLSQ9ouy/zdiuVDJ221AvYrU6dALvSVeHP/Xf7em3Mv8h/qtbusHTzVdKYiKbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjrvivF+XaMRlYrnGqaSTlecPHx/G2Bqfxc2cQrlQNU=;
 b=qW4I/NH4ZN5zQKd3SgZyDPY3ticUk8ek+CwOWYnHaC/FGcWoN886HHlqANLJOf29PEEjXVs3L1j0E3rLIxBdlJBVfwwhGzmjdagmqYMjfpd6F97Hkz2pppy//ZaqQui9iSZEJo5XUGNgTn24y901+nH7f50hAysgdpE9YmaSXrtwpFwhQ6AQYMCR0FQ+BMrttc+yE3usGAwb6Vrzlz9uzJpoaEkFo+grlP2tmX2rQf7CxJVF5QzZx4ZT37fjzsY1/TH4fLg4rdEKWiQE6m9CeguujfrD5trtJqcRNUTZ400988i4Sd/toXkCB1tK3y//8XsHEOjOKMCd2z/189f1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from DM8PR14MB5221.namprd14.prod.outlook.com (2603:10b6:8:28::14) by
 DS0PR14MB7256.namprd14.prod.outlook.com (2603:10b6:8:15c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 22:56:24 +0000
Received: from DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2]) by DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 22:56:24 +0000
From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Topic: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Index: AdsAr6R5Wepb7bi8QyKU1geEa5bTeQ==
Date: Fri, 6 Sep 2024 22:56:24 +0000
Message-ID: <DM8PR14MB522160ACF4E64A9400F93E4EEF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-titus-metadata-40: =?us-ascii?Q?eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpc?=
 =?us-ascii?Q?L1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ZMSVIiLCJpZCI6ImFmYzEwM2MwLWU4?=
 =?us-ascii?Q?YzItNDBjNC1iNzg2LTk5NzljOTZlYzYxMiIsInByb3BzIjpbeyJuIjoiRUNJ?=
 =?us-ascii?Q?RGF0YSIsInZhbHMiOlt7InZhbHVlIjoiTk9vckVBUjk5In1dfSx7Im4iOiJF?=
 =?us-ascii?Q?Q0lKdXJpcyIsInZhbHMiOltdfSx7Im4iOiJFQ0lJVEFSQ2xhc3MiLCJ2YWxz?=
 =?us-ascii?Q?IjpbXX0seyJuIjoiRUNJRUFSQ2xhc3MiLCJ2YWxzIjpbXX0seyJuIjoibm9u?=
 =?us-ascii?Q?VVNDb3VudHJ5IiwidmFscyI6W119LHsibiI6Im5vblVTRUNJSnVyaXMiLCJ2?=
 =?us-ascii?Q?YWxzIjpbXX0seyJuIjoiVW5yZXNDb21wRXh0IiwidmFscyI6W3sidmFsdWUi?=
 =?us-ascii?Q?OiJOTyJ9XX0seyJuIjoiQ29tcFNlbnMiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5P?=
 =?us-ascii?Q?In1dfSx7Im4iOiJJbmNsdWRlQ29tcFNlbnNNYXJraW5nIiwidmFscyI6W119?=
 =?us-ascii?Q?LHsibiI6IkNvbmZMZWdQcmkiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5PIn1dfSx7?=
 =?us-ascii?Q?Im4iOiJQSUlEYXRhIiwidmFscyI6W3sidmFsdWUiOiJOTyJ9XX0seyJuIjoi?=
 =?us-ascii?Q?Q1VJRGF0YSIsInZhbHMiOlt7InZhbHVlIjoiTk8ifV19LHsibiI6IkNVSUNh?=
 =?us-ascii?Q?dGVnb3J5IiwidmFscyI6W119LHsibiI6IkRpc3NlbWluYXRpb24iLCJ2YWxz?=
 =?us-ascii?Q?IjpbXX0seyJuIjoiUmVsVG8iLCJ2YWxzIjpbXX0seyJuIjoiRGlzcGxheU9u?=
 =?us-ascii?Q?bHkiLCJ2YWxzIjpbXX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNp?=
 =?us-ascii?Q?b24iOiIyMy42LjI0MDMuMSIsIlRydXN0ZWRMYWJlbEhhc2giOiJVRWFWUFMr?=
 =?us-ascii?Q?c1pnT2VOMG5MS0VIUUw0MWo5WG40cFhXaEY5cmhtRU1KekRyM1l3WDVxbHlU?=
 =?us-ascii?Q?U0xiM0YxMGw4TjRUIn0=3D?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR14MB5221:EE_|DS0PR14MB7256:EE_
x-ms-office365-filtering-correlation-id: e638299f-f779-40f8-f9bb-08dccec7221d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aDxpmFzK7Nri9QFniGzg58+SeQBnK+TUgBlusuSZbJCIWxUBY0xWcjKjXfTs?=
 =?us-ascii?Q?cQp6x6rJ3JVZ7p3D5lLdtNIydBBSYeBX3I5EstYEUkvyb1foMzOu9NmeOBzh?=
 =?us-ascii?Q?4CYkiVpJZzjWPdjz7FhGQwQGkYp6Tuqz/syU0ALC09qfw9WJQPdLXdcxOMN6?=
 =?us-ascii?Q?Rha6SWZgl/M1I1E3Fn2TjH37xaimqklf+KgKsliGMGN559lWD8Q4/tkTahCJ?=
 =?us-ascii?Q?vCUaiF/2sGfyvNR2jdZE5qU1GogVu9ir1Rl5kQyrXDT1GT7oj+tieba7yv4A?=
 =?us-ascii?Q?Xg5jmOPnknSbhoxos3uqH4vFm29UuZsmkT5ayEVC0qjgJLkhoBZbLgWuoamX?=
 =?us-ascii?Q?0g1G27WxG1XFlIQPSVgwi+cPPlpX47fTL4ICvU3XQkBQuTn7FdUTr3sBmlWk?=
 =?us-ascii?Q?YHBes689dqUdvNn2tLamcctqpGDTP1XJGhP+aAsbpg7lO5W/iyTKZ9my2WDR?=
 =?us-ascii?Q?wg2wtP/n60PhUJI9D2j/hz7bGxXezvuzLdX+PnNh5q7TTZ74qfewdKBI6D6k?=
 =?us-ascii?Q?YfNqWozMHm0hvahOFgB9NnrxB55CZ8PYKPYhb04lHC8peaHr9ZOuUMvYkxPM?=
 =?us-ascii?Q?2FYo52jLKCNWfk5i1zGpVpJ389p7LZv/todGBGvFxox1TvOo86+R1/F5LoKE?=
 =?us-ascii?Q?ONbULiiaOeqFkMNTid+P1SP+5dYMLPdcY8Jn1fxTEVGZdHyK2C9lJnDHog8O?=
 =?us-ascii?Q?y9VXcvXqEd+pucSZQsDdfq/BD6Xf1p5+EfFxwLAxRdMs/dUIFAjR9ctoxAWg?=
 =?us-ascii?Q?XOKngY+RchRpyv5IxZL/3C7hUthgMMtWPXEcwZouk4xrbWvAYa7lLjpZqhQN?=
 =?us-ascii?Q?G+04Vcje9k5vJlWtLCM+NStIcUsmmYn3ZnCqS9zXRYEYtA8BNSnBxJrjZqM6?=
 =?us-ascii?Q?xv2jbqxjj0PK7K0h5Q8bhiZvCNh2PANy+NYZzvli02dOi92Qr0VQaglWiUUS?=
 =?us-ascii?Q?LszEXzAIuaH/aQRod//4+tqPUpFEt2/xRn3jMOKUzOf9scE9WQ/fZDi4D6H3?=
 =?us-ascii?Q?+HgQ0GiEKaNlF4AXe7LTDX7AruKYuwbt6/DhMMAXklnG358JTwMTcvgsfHcv?=
 =?us-ascii?Q?EYTF3fxd12HbUh0I0x8NR/ptY2uj6HBFXY8fofroTgFhyQqSztwHo0HA6SI7?=
 =?us-ascii?Q?/YAzhmrtwKJzzMQaSPv7+vLefrenDb8tJd0l8FpEYE6vBMRuajDk3Ni2ZXp+?=
 =?us-ascii?Q?qMqHtMjmOELSCWSLyPpAwaoJR1Wp2PVvuqvpYQqdFVk4jt0ISaFfwTyXNQpM?=
 =?us-ascii?Q?4WWihtDp0tXcdcqrcmo/8E+HIfxObgz3sNyC5F4A4rs8rOHadSctgNR5PUUW?=
 =?us-ascii?Q?A/N7LirFr3heI7LuKb0ml/JfHMctXxjJWngIqjZZDIRkRZrWiEf4cYog8rG4?=
 =?us-ascii?Q?uj3n61SjIktr74MbtXd5YwtFDfupipRzqAIAusZeo00OspycNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR14MB5221.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NA4LFmhNyFQJGX/jj9hVB4DfnAlwTD0izygxDylyiC93FTS/hws4ztHutL7x?=
 =?us-ascii?Q?sP8iVkfB2jjd9Qhp2xYtlRSvSLlWgZFr48xAO3CmGN3BhyWTbJ/kXKjVP4wt?=
 =?us-ascii?Q?/7IR1CgA1kyuJVpzIm6IYAkTkO/8FI+qoA2UHu+X+ZffgyHSLMW0OKO1R0Mt?=
 =?us-ascii?Q?wobzRor0DAcmQonbguN45iKJwdtMyJ8R5xGT0hUPw4dj48O2zFIXEP9Pyy43?=
 =?us-ascii?Q?aD+OwwA6rpYqub1FPODmojmrRn/Q/xNdEqts5DqIoYr12EWXU0D9q+tZXttJ?=
 =?us-ascii?Q?aXUxYV7+AgFl7H+4oP0QQCL7QhUSo2XQyMgrZQTivW9SDasuJAZUYv+WBGfT?=
 =?us-ascii?Q?YDDxqLWZE+IWiS/Exf0ugmxze/5RIBYSXILbPu4nMQnlEkuJvbb+5MXV395X?=
 =?us-ascii?Q?Hv5zWCI5gb3Qwh/XOSAs3GB9D9ON7NxiTePS9O0Gy6cvh51qbA0d4mLjrCs/?=
 =?us-ascii?Q?Z6LnI58JYkBPWq6EeDtb0WUlG2rM7zb0IU8XJriLjIir+EZYBykzLHEHP6WV?=
 =?us-ascii?Q?WYYUEcBNXUDX2UlJ/D7F3lBtZ+jp+YJ/CjIVxwtLWx4dEgeUZhu2u373SVug?=
 =?us-ascii?Q?WSSKmlcv29khEUQ1Xu0JB05oW6Sbvl7TvZTgKgpYcyjNNfKrKszgegyvv6q5?=
 =?us-ascii?Q?IdJhjMFk0+NhzAcwCYx1YTg3DZPd7chAqA8G/a6uSbNMS9PNCzX36XD7o1Y2?=
 =?us-ascii?Q?Ot9ScamEyKQGp+1rsqL6Krp6lDyDEl+gBvxpCz/M4jWa8k7kS2BJxHy7WgJw?=
 =?us-ascii?Q?u7Ff2uH8enwlMbuyinYq9PXeMU9cCmmBWPPm1Lmv53ZV/8XzfqttTYlyhrEq?=
 =?us-ascii?Q?01s0423SU/mwCNNlkRcpTio6WnWHJVbTrQQnrxe/JPVLPzuItZ6Tmv4tLFEa?=
 =?us-ascii?Q?iWhvg7iYwl5fE3MGvnn+kKYFKznxdmfUU0F8WGiCV2YCEEOHQ2E9T/7bGCtZ?=
 =?us-ascii?Q?4tlFpljb80gVMI6mRAFZm28LwZ8pSws3swA2N/rX3CD8Ec9CGHNLfl22TUxT?=
 =?us-ascii?Q?p4CiBUGL0IZnD3OAyNRZ1aRFShOY8i+LWehzzt0RgKliZiuuxNv/AT2BI2nc?=
 =?us-ascii?Q?05GEVgQH3Wi3yRrJRtoaRV7qE42pxiWpiaOVAXV5OAlThjV5Mg6UY9oMdTvF?=
 =?us-ascii?Q?LB3jaMHoLcQ+IX/DFRZAIj/jwN85pb2XOtC18vK0iHanyh2ek5EBpq5pemnl?=
 =?us-ascii?Q?iLvXFoQX0dBOP7of++921q0Kbptkc/Kp993h7sbpbBzmH0FFYwhQz1rHGhgE?=
 =?us-ascii?Q?I4RGsjrTHDgwced8VBHFKtj1hkGB2o2Ca63QkVbN729Z3BQziCZCevZEjUv0?=
 =?us-ascii?Q?E44Nz6E6zjaQVyRPCP12svXP3qzrne83imCHcsaDHfmx6KDIXD4lvtEDs53C?=
 =?us-ascii?Q?r8fVmEDogcGx3MNZlpZEZsTQRkKfRZBIUnvv+A8FUlbYComtAaOu2ilY0WfQ?=
 =?us-ascii?Q?ccrlcZka0HQSCNKXeM0ewe6y5bzbzvL383W4WWo3gWnOazmfRp7uqV+yFmy0?=
 =?us-ascii?Q?Xr7sUXn9Wr5UnXenHF1jr52KRoaa45ftnpR3/exDonUSjNTx0bksDDIMZMsk?=
 =?us-ascii?Q?vv+Jq0kcDhMXJLXqqmUoq5TSbn7OIa+QB7E/DoTH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR14MB5221.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e638299f-f779-40f8-f9bb-08dccec7221d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 22:56:24.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2b0XAW694qVuPayf89jLgWwYcTws3NE9wXvpF3gNn6HBQuNO2eKTrmojv9RDV47XjF0gTJhxjWI252Xx+F21PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB7256
X-OriginatorOrg: Teledyne.com

If any error flags are set when bringing up the CAN device, e.g. due to
CAN bus traffic before initializing the device, when m_can_start is
called and interrupts are enabled, m_can_isr is called immediately,
which disables all CAN interrupts and calls napi_schedule.

Because napi_enable isn't called until later in m_can_open, the call to
napi_schedule never schedules the m_can_poll callback and the device is
left with interrupts disabled and can't receive any CAN packets until
rebooted. This can be verified by running "cansend" from another device
before setting the bitrate and calling "ip link set up can0" on the test
device. Adding debug lines to m_can_isr shows it's called with flags
(IR_EP | IR_EW | IR_CRCE), which calls m_can_disable_all_interrupts and
napi_schedule, and then m_can_poll is never called.

Move the call to napi_enable above the call to m_can_start to enable any
initial interrupt flags to be handled by m_can_poll so that interrupts
are reenabled. Add a call to napi_disable in the error handling section
of m_can_open, to handle the case where later functions return errors.

Also, in m_can_close, move the call to napi_disable below the call to
m_can_stop to ensure all interrupts are handled when bringing down the
device. This race condition is much less likely to occur.

While testing, I noticed that IR_TSW (timestamp wraparound) fires at
about 1 Hz, but the driver doesn't care about it. Add it to the list of
interrupts to disable in m_can_chip_config to reduce unneeded wakeups.

Tested on a Microchip SAMA7G54 MPU. The fix should be applicable to any
SoC with a Bosch M_CAN controller.
---
 drivers/net/can/m_can/m_can.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01d..4ced830f5ece 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1434,7 +1434,8 @@ static int m_can_chip_config(struct net_device *dev)
=20
 	/* Disable unused interrupts */
 	interrupts &=3D ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
-			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F |
+			IR_TSW);
=20
 	err =3D m_can_config_enable(cdev);
 	if (err)
@@ -1763,13 +1764,14 @@ static int m_can_close(struct net_device *dev)
=20
 	netif_stop_queue(dev);
=20
-	if (!cdev->is_peripheral)
-		napi_disable(&cdev->napi);
-
 	m_can_stop(dev);
 	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
=20
+	/* disable NAPI after disabling interrupts */
+	if (!cdev->is_peripheral)
+		napi_disable(&cdev->napi);
+
 	m_can_clean(dev);
=20
 	if (cdev->is_peripheral) {
@@ -2031,6 +2033,10 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		can_rx_offload_enable(&cdev->offload);
=20
+	/* enable NAPI before enabling interrupts */
+	if (!cdev->is_peripheral)
+		napi_enable(&cdev->napi);
+
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
 		cdev->tx_wq =3D alloc_ordered_workqueue("mcan_wq",
@@ -2063,9 +2069,6 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto exit_start_fail;
=20
-	if (!cdev->is_peripheral)
-		napi_enable(&cdev->napi);
-
 	netif_start_queue(dev);
=20
 	return 0;
@@ -2077,6 +2080,8 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
+	if (!cdev->is_peripheral)
+		napi_disable(&cdev->napi);
 	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
--=20
2.34.1


