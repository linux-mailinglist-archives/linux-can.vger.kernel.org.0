Return-Path: <linux-can+bounces-2691-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085AEA1B297
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 10:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8631889389
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D1E21A435;
	Fri, 24 Jan 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens-healthineers.com header.i=@siemens-healthineers.com header.b="PDnM0Xsi"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAA219E8F
	for <linux-can@vger.kernel.org>; Fri, 24 Jan 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710934; cv=fail; b=U+e5T6avcWWYOAvTwIchb/YM6/Qp/8epXeLsIETVMHFag9x1qm2YXA2lVREJbhKxK6AtunFhFDZbiZ9AO5ZNP7+gomUu0eE4nAb1cim3H2/EdTTAbiEQIhuXTbdUbZtK63GI7o3AXy2hIDSkd0iSLGyVTeaYXaHiDGA5cQVAtXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710934; c=relaxed/simple;
	bh=m6IkaetDw/0Ieocg/bo7saX9taFb5XaLDp40jdnxsqY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I/qB1RlFnesncbAvPDZjQcRdjMssLB1bXaH8+/Mnk8Hw72oRu3PUX0a552i2b/IoXu/+RR7hHkiS0dBxqIbqB2LAPGfdh2kRFIBElq1KuYIzMMntM6XBYcV1r3TibPKfDdkEm4UBPJ5TMaHkIL2RvSA5VT9UcOHY5Q1DeAkyB6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siemens-healthineers.com; spf=pass smtp.mailfrom=siemens-healthineers.com; dkim=pass (2048-bit key) header.d=siemens-healthineers.com header.i=@siemens-healthineers.com header.b=PDnM0Xsi; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siemens-healthineers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens-healthineers.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvRbW/9nsDDnW91zaUFv330qKRa7GzB+IY8zyuPCkk/vr8oV1y/Yb+TYGo39SP8VvzPymRH0My9C5S3e+k8/XcVAKuHAWBQeerI+snTmppKcKoFioqdV4NN/wcMWM0ldLBkJuEGxO//gieHWcmxYMD1oABqUB/pMPzthWtR0mn1WTTMKyVVsLGFWdOCxt6rp3EpZc4ygXfIb+Olt+h2A/XAsyeGq4yFRflUmuxD/1EOdjqecbat99zpldPBN5MaPQ0xsvNxoQHAyEc3Lx1shRkLtdOvtxCx5/ebDHm0xyb8FJVOVNeS2jfCpZ92qCbEgJAIeSDJfYRjQJ6kN+DITiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1yZ5m7fuLVa+PiHUYqERoEQQnlvfob+1vIFzQGukrs=;
 b=q2NAAjqPtPuQzuDjnU7PzaFzMk1QChA3MMbMje7sXKtbGY8FJS8epeALhVsKygo5W8b7uFnc3KBagsTf9OEWriPYfi7Rza37xCgW1TNFzWE0YT7qMTIUy9xf4daUgyQxFsgzWffA3Emlf3Wp1rNi8Qxz0A6sVV9/WWxEMtQUMG4nwIb/qV88NMJa/739+3JiMe3qRlSVqw7NUqLzH3cDBF6RSFtM79rtDwG5+vlKgaWg9JPVTJR2tZA/dD5lqnBf2x3dw1O98NDfAHQ//MwaLM7ihQK5fgt98g+k+tJmjpkYXOSfw+oaJ3pZKdMbbfdkYosuMebwnVcIWzELZNQX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens-healthineers.com; dmarc=pass action=none
 header.from=siemens-healthineers.com; dkim=pass
 header.d=siemens-healthineers.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens-healthineers.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1yZ5m7fuLVa+PiHUYqERoEQQnlvfob+1vIFzQGukrs=;
 b=PDnM0XsiV/RMFX8s2mAQQzTs+iSZa+81L4ydslqtouz+IDo2N2rarhLeSY0AKhJQIQAQL6RAjEQJKkjUIBxTA6E9c/SBlbsTSqal6NehR68G5Cx9yJQ6xaaY0ngEfXnQo6jn8RoZY6vFvVGzMNPFKIYRczBCZCe70kzgJiACz3RGrf7iytBdYbyvsBf+xUDHW0O0L5Z8RS3x6gSC7pw+c4XIvEbtp02bpLc9fFW5LhhkL7TewEJDEZTV86CNT42SBSAeLVcO93pEGlHtNDbx26hS6jgM1uVluOfHXH1MeyoAUgIAtVcmKb9uxmh9RwzHVdNrDq61AzTC//uHgSwSIw==
Received: from AM8PR05MB8052.eurprd05.prod.outlook.com (2603:10a6:20b:354::24)
 by VI1PR05MB10787.eurprd05.prod.outlook.com (2603:10a6:800:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 09:28:47 +0000
Received: from AM8PR05MB8052.eurprd05.prod.outlook.com
 ([fe80::3382:8748:39bf:2aaf]) by AM8PR05MB8052.eurprd05.prod.outlook.com
 ([fe80::3382:8748:39bf:2aaf%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 09:28:47 +0000
From: "Schmidt, Stefan" <schmidtssstefan@siemens-healthineers.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: [Issue] Bosch D_CAN echo skb occupied error
Thread-Topic: [Issue] Bosch D_CAN echo skb occupied error
Thread-Index: AdtuMmK9G5mX0qQdSFmTpbPNYtx/Bw==
Date: Fri, 24 Jan 2025 09:28:47 +0000
Message-ID:
 <AM8PR05MB8052EFD0609D2F65BECBE1AE8FE32@AM8PR05MB8052.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_ActionId=71ad076d-3c9b-4b08-856c-5c2c6693db5a;MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_ContentBits=0;MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_Enabled=true;MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_Method=Standard;MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_Name=Restricted
 -
 Default;MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_SetDate=2025-01-24T07:32:22Z;MSIP_Label_ff6dbec8-95a8-4638-9f5f-bd076536645c_SiteId=5dbf1add-202a-4b8d-815b-bf0fb024e033;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens-healthineers.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR05MB8052:EE_|VI1PR05MB10787:EE_
x-ms-office365-filtering-correlation-id: 1002f2d7-71e2-4587-5f39-08dd3c598177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BDctoBe4T4BXDcZUW7fsBteGIP4DZR2EOhQcW0LUbfEjJSZ+k9AbxnMy+3hz?=
 =?us-ascii?Q?mWxIhjmAV96/1os3U2mri3hEAdW9T1gpSyaRnL4NbxD+CVXWSoeKBGeismur?=
 =?us-ascii?Q?hYoyhwQ/jcHo0qH0AcYuQYuUgXi6Rr0InIcZgqHM/OjaB9B25soicfzMFHRJ?=
 =?us-ascii?Q?/NBZpk83/YjnXSoBBDvRcq5p5MkMLctgtM7zzpXrvTCgkVs4u7a/JbAR32df?=
 =?us-ascii?Q?Je7ZX4xrhQJrx3Vu/KPl6pk5MM0SDk21n4vnzwp5xR4yPUMri9rMa6kMWTEc?=
 =?us-ascii?Q?kmeMkTdVlVHRxPUYY1ykc9wJKrybu8tKVMrCbCjkPmEcdmYexpFnPHUX+ACW?=
 =?us-ascii?Q?4Z9a1yx6fY1xbzpOgF+8w7slVVqS2jb/h3ZWPHsMH+ROBbW7QkJuOhQiryMw?=
 =?us-ascii?Q?UmCuShBnAP0BD2N+7gK0iIDt8apMlCm82y4+8qSyqJO4zpOYW2akQnNrWKmj?=
 =?us-ascii?Q?FphBzn5r0YvVN973vuXoehC3OyjRp3tdbSQfMZp9NJN2hslgIuEoWKPJraCW?=
 =?us-ascii?Q?iioYcIdnyHldUjg8y13/GZBUUaxIr6bXZ09gdEkoHfJLXFnqwqL0imBlSq0O?=
 =?us-ascii?Q?wGZMI3AgSGtW2icFXOh2O4F+YMh5tvldJV8/QqzLaq0s+sakb1vAAAN2zR8Q?=
 =?us-ascii?Q?cOS3ht1JCQ90CmcpqAf8267FDP8zqtCyz5ivmRD7+V2f32/e8W9GIXfkNd56?=
 =?us-ascii?Q?PagxqwTaImtD7jmzgHMUTRtIXgqOFU2wCqsZ5Zo2ODr/dxSGk/JgjdS6/bHD?=
 =?us-ascii?Q?Rzi/RZQQPr7mcg7dp1nkZgIN+XCVskrdTPeCpwfnWY8yPWp5NDvAtrqIEYwF?=
 =?us-ascii?Q?O1CA8t9i9a8HEK7Ofb9RhB5g8wTJRU2t2sHxMjVJ1gdFax0gEazC9LBoOiZS?=
 =?us-ascii?Q?3Nq6SYpS6mb7Hq5adJK9aHtbnChZIJguCsHPA8LcHvrTuC3aVtc2BbuowgUf?=
 =?us-ascii?Q?HaurafIeGjnrUYqBSh34lWO33hZI7s125U2LOlpgwYjvW+KOfdGp18VdLrsC?=
 =?us-ascii?Q?+ZonupzGKLtQLe1EAKJXHGxwI5OwjYEUlqYTgWJME8nxdxbUEKIODfxJeGF+?=
 =?us-ascii?Q?5MmU/qtUQi/b0qtjXHOyieo4RrHrSQzU/H+43cAJrEaujEBSE1wZnVe01M4s?=
 =?us-ascii?Q?vnN1CkncpFrVkJ6A9AqSYEfPumj9ljTB86AIOBWdWTYUNOpjFA7CpSHqOeEI?=
 =?us-ascii?Q?bD/4+FIp4WxOnisBmawka+kH8vKSxoTPONUoCKIv4yOt0Oj5buVwh3/tKBOV?=
 =?us-ascii?Q?Gj+pG83SVg8BB1AIBbEWcd/fFA6SUFe/YHZ+je1JBToDv8CDe38/trVwNMRo?=
 =?us-ascii?Q?7+TQzWu/+4AYEVhlBRCriXEA//VvW7XmAqpAZTA+c39y+SQ0nMTvzNlmSXji?=
 =?us-ascii?Q?cs4HRNGNtHSz1FKJsgorKrUWeCeg/E22cRHVY8/DO110F6o2jm3jU3INJukC?=
 =?us-ascii?Q?Tsx+dJaI7h32RWUU/7Bd1urTUIRhqXei?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB8052.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kv30fYEsm9xgAHQDILM515IzXkmLAUHKjIz5niiYEfsV5yUfPrlSM+pmzLPs?=
 =?us-ascii?Q?Z44L/6MJfa055mw17AwcqhRCyE1MHpOIp6nygURmX/nzL8hzfGFqqfhwBLha?=
 =?us-ascii?Q?SQHqEHkxL86lkQbeEgYhTv2A1u/cuUPL3bwYIB1kUvz8MlD0F7yR9aHU7Rgb?=
 =?us-ascii?Q?4XAZQt7FwFaC72gWgEVQT91U0hjrMk5D96ARts5TSU7DpZjKvYLeXSvje26c?=
 =?us-ascii?Q?EvS560FsCsNM5J6Xqaw45oaCY5SQ4RCZ+2P9Hggfct1wxZiy2DwxlphOF8Fe?=
 =?us-ascii?Q?Vvub6RvG/H1VatH1XO4Cil+8lk5jFI0gcQNb9ktUuOsyTTq1lKtGPS06UhsK?=
 =?us-ascii?Q?UdxJ5jypaRRlssU+PQl9AYwpEL07zvgWsAKkRVYyuhEd2JyiJbHl3f4qGbEm?=
 =?us-ascii?Q?UtyPWshDOkE8RclGkx0uVQLvP3JkKAcVuPwx7WwJ4+2R5jzIKtIvjusojl67?=
 =?us-ascii?Q?eJhiovhnkYCWaN7j8yBtqTMpY5IGWpD5qvTl2NjcdB6lVBP2nc0MONirH1HV?=
 =?us-ascii?Q?1rYWKelCHKECW7MXvbxMIhzJEzuLWHZkUU3gd4bZwG0mOuP5SQG8pxzIDcB1?=
 =?us-ascii?Q?7GC8fpvu7q+UhYjPdYeMeWqllf4z9j55BLFaj2VMVUX16IS0jfO8KORhPPDd?=
 =?us-ascii?Q?JyTQMuHe3CpzbEIjEADi2wd44Mo9Ip3yjkzcJ67VbtuCqdAcC4ieTbzXuSrr?=
 =?us-ascii?Q?l2tbWa8fuwPSy0L6zx/AK2yDQcglRKhDEVoqjjZ4g1WaCwsoIW2ecd0Fp9C4?=
 =?us-ascii?Q?YHFUU95QSuTtty5xxOxeTTMcksSSeRgGYLaML7hvuyMWCzVA80Sb2oQW6+wj?=
 =?us-ascii?Q?w3nYAzsUurq77YPBsMBJJUudBMy+iJHi2TcwM3eZcFPIfO4XDlcXrH0ndaLn?=
 =?us-ascii?Q?rK8iigrkho/+f02QI/pCcu9CnaKIuX0hCCfRJ7NE+6VQE+j9uCL5hJm3+FfO?=
 =?us-ascii?Q?C9+9UP+G+gHzxbkecjWaLGn2UHt43ZUBTa8+c5sfnwm6Ofep5mhCGls3LxHi?=
 =?us-ascii?Q?ZqKxdeKSu3CaQDDs7fPIRSOBxeSvneUci1UtI+Q0QiTwxJbA61EgMji+9BiX?=
 =?us-ascii?Q?hNhbb1SzcVkdE4OhUdVMe/YyQRzcJalEdM4hFcYAVXNxXFVt1ulwOGyUbGAk?=
 =?us-ascii?Q?+931vkmJ3jg/figA3G7yh2Zv2w6P7rAkbgzi+WPcO/Qmm4n4h1gnZdXMoMLs?=
 =?us-ascii?Q?n7FyHdFEES+pzq+pRDCMsab96zPFWdPHm+AofOylsIYHaVkPzghhq23AsQ6s?=
 =?us-ascii?Q?LbI3+Yf3OdJsQEK0bp2qTPljOA5+7g8KbgdAP50UqgpjHfuvSApYxKhjeRBc?=
 =?us-ascii?Q?zIk8wJ2tSu9IHmhE/bY3o22wwXrv5SfdGOvytyeVa9olaolsbj5qhJbXV9mH?=
 =?us-ascii?Q?uHi7nTZUdOjIEPZc4ZMxyPAqyQP7EZDctfIhFe6sWSMPkZM7SzPZxMQq5dlW?=
 =?us-ascii?Q?Z161LwM0/eXB1uOzzyy9OHyHTFlUrbort1vehZrfq2j/CtXfTI4wOXdYLwhD?=
 =?us-ascii?Q?6L57hIq3bCGwq2H+zz+hARcE0zmmkDBpJEfsDQ+e8CF/CepNZH2vDFyTlQb0?=
 =?us-ascii?Q?DxApabuaWrbH5GjCtl71Dfelb0shGZVzn3DgAZDSoU+kxupTsgn90GVXdrTP?=
 =?us-ascii?Q?02cOxlqk/zZMdrbmHpyXrJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens-healthineers.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB8052.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1002f2d7-71e2-4587-5f39-08dd3c598177
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 09:28:47.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5dbf1add-202a-4b8d-815b-bf0fb024e033
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+b0vUr+2/sQPEpgCeo4tcadY2EsrKXgA/We2cXlKuAzH8ZO5iXE4lSqK9dOlbaZapr4hI/8EWbzjF5vThlcVhpvEsoJX7UYtWLHaO6zIlFRIo/upoCRPYTS9eI6162NDrDX+UEG1zZYwuycYlzhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB10787

Dear linux-can Members,

I hope this message finds you well. My name is Stefan Schmidt, and I am rea=
ching out to seek your guidance regarding the "echo socket buffer occupied =
error".

Context:
Recently, we updated our kernel from 4.14 to 6.1.43 and our Debian from 10 =
to 12.
The system runs on an Altera Cyclone V, which has two Bosch D_CAN CAN Contr=
ollers on board. We use both. Additionally, it is a dual core system with t=
wo Arm cores.

Issue:
After the update, I saw that both CAN devices sporadically print the messag=
e "BUG! echo_skb %d is occupied!" once into the syslog, with %d always bein=
g index 0.
From there on the affected device was unable to send any messages. A restar=
t of the device (ifdown/up) recovered the problem.

Steps Taken:
After heavily polluting the driver with trace points, I found out that in t=
his case, the echo socket buffer is indeed still occupied by an old message=
 on index 0.
Looking at the preceding usage of index 0, I saw that both functions c_can_=
start_xmit and c_can_do_tx  (drivers/net/can/c_can/c_can_main.c ) were exec=
uted on different cores at the same time.
One was called by the tx-interrupt of the CAN controller and was scheduled =
on CPU0.
The other one was called by the application / network layer and was schedul=
ed on CPU1.
As both functions operate on the same resources (variables in RAM and CAN c=
ontroller registers), I think that there should be some kind of synchroniza=
tion mechanism, but I did not find any in the code.

Theory:
I think that the caching mechanism, that was introduced somewhen after the =
4.14 version of the kernel, can get compromised by this parallel execution.
In the beginning of c_can_start_xmit, the function checks if there is a wra=
p around in the buffer. If this is the case, the message just gets prepared=
, everything gets written to the chip, but the final transmission request i=
s not set.
```c
// (1) drivers/net/can/c_can/c_can_main.c - c_can_start_xmit
cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
```
In the end of c_can_start_xmit this command gets written to the CAN control=
ler.
```c
// (2) drivers/net/can/c_can/c_can_main.c - c_can_start_xmit
c_can_object_put(dev, IF_TX, obj, cmd);
```
The final trigger to send the message shall then be set in the tx-interrupt=
, as soon as message from object index 15 (last index) was processed, becau=
se otherwise, the new message on index 0 would bypass the one on index 15 a=
nd change the order in which they are put on the bus.
```c
// (3) drivers/net/can/c_can/c_can_main.c - c_can_do_tx =20
c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST);
```
My theory is, that as it is possible that both functions run parallel on di=
fferent CPUs, I think that it is possible that this can happen that it happ=
ens in this order (1) -> (3) -> (2). Which leads to the situation that the =
transmission request bit is immediately reset after being set.
To support my theory, I put a spinlock around both critical code sections. =
As of now, this seems to properly solve the issue, but I am aware that this=
 is probably the clumsiest way to do it.

Request:
I am reaching out to you because I have not found anyone else with a simila=
r problem on the internet.
It would be great if you could share your thought about this problem and ma=
ybe give some hints for a cleaner solution.

Additional Details:
Please find my clumsy fix with the spinlock below. I don't think that it is=
 ready to be merged to any official repository, but maybe it is a short-ter=
m help for someone who is in a similar situation.

Thank you in advance for your time and assistance. I look forward to hearin=
g your suggestions or advice.

Best regards,
Stefan Schmidt


diff -ruN a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -22,6 +22,8 @@
 #ifndef C_CAN_H
 #define C_CAN_H
=20
+#include <linux/spinlock.h>
+
 enum reg {
 	C_CAN_CTRL_REG =3D 0,
 	C_CAN_CTRL_EX_REG,
@@ -201,6 +203,7 @@
 	unsigned long tx_dir;
 	int last_status;
 	struct c_can_tx_ring tx;
+	spinlock_t tx_obj_lock;
 	u16 (*read_reg)(const struct c_can_priv *priv, enum reg index);
 	void (*write_reg)(const struct c_can_priv *priv, enum reg index, u16 val)=
;
 	u32 (*read_reg32)(const struct c_can_priv *priv, enum reg index);
diff -ruN a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_ca=
n_main.c
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -463,8 +463,9 @@
 	if (c_can_tx_busy(priv, tx_ring))
 		return NETDEV_TX_BUSY;
=20
+	spin_lock(&priv->tx_obj_lock);
+
 	idx =3D c_can_get_tx_head(tx_ring);
-	tx_ring->head++;
 	if (c_can_get_tx_free(priv, tx_ring) =3D=3D 0)
 		netif_stop_queue(dev);
=20
@@ -480,6 +481,11 @@
 	obj =3D idx + priv->msg_obj_tx_first;
 	c_can_object_put(dev, IF_TX, obj, cmd);
=20
+	tx_ring->head++;
+	smp_mb();
+
+	spin_unlock(&priv->tx_obj_lock);
+
 	return NETDEV_TX_OK;
 }
=20
@@ -625,6 +631,8 @@
 	tx_ring->tail =3D 0;
 	priv->tx_dir =3D 0;
=20
+	spin_lock_init(&priv->tx_obj_lock);
+
 	/* set bittiming params */
 	return c_can_set_bittiming(dev);
 }
@@ -724,6 +732,9 @@
 	struct net_device_stats *stats =3D &dev->stats;
 	u32 idx, obj, pkts =3D 0, bytes =3D 0, pend;
 	u8 tail;
+	unsigned long flags =3D 0;
+
+	spin_lock_irqsave(&priv->tx_obj_lock, flags);
=20
 	if (priv->msg_obj_tx_last > 32)
 		pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
@@ -744,8 +755,10 @@
 		pkts++;
 	}
=20
-	if (!pkts)
+	if (!pkts) {
+		spin_unlock_irqrestore(&priv->tx_obj_lock, flags);
 		return;
+	}
=20
 	tx_ring->tail +=3D pkts;
 	if (c_can_get_tx_free(priv, tx_ring)) {
@@ -769,6 +782,8 @@
 			c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST);
 		}
 	}
+
+	spin_unlock_irqrestore(&priv->tx_obj_lock, flags);
 }
=20
 /* If we have a gap in the pending bits, that means we either

