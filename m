Return-Path: <linux-can+bounces-7127-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB6kMBpxumnRWQIAu9opvQ
	(envelope-from <linux-can+bounces-7127-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:32:10 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 686262B915C
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 296EA304D81C
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B43A9615;
	Wed, 18 Mar 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CrmT8MCk"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CC3A8751;
	Wed, 18 Mar 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825744; cv=fail; b=e1DhpZMxePEL/3UiQHQM8Hxq0P8jYmVDpEaN+C/cHsxb/A0Ihj92KPvKfh+vb/TNP+fww9bJlA3DnX+BOQKv4/8EcS9AM4PkA1ku8OdDj99FemSqXWLAZbIMrqmk+Vu9vG7u+y9s2UaFaVdyAOqnw6ZC02bQEC7/gWDu2zd0b9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825744; c=relaxed/simple;
	bh=ywwWl2cBQeBfzrraaDwfIKFhfdP8mvk2TsbyFb+AqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E1almOecS55alJ1dF2ZCemwLGaCtozKfOVh4bMO2g10J2N7FxbSla1fdDKf6HDYa9AnCMYyv2ldS6k8k3QCMPimtrte1Z4mtY4JW7N7aFe55jpqabLPuPAI0nd6ce2FYOrwyNfQeOe+N7pKoH/8XCO40wYTaw0t0wzMBUvc/krw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CrmT8MCk; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkfRd8NnhXINTUiRHFUA+sKLpvWrGjN1M+P/E/ntwnfDb2eqEYhppZeIVFqyvLuuEx8ht4OTLRf4sLflAOWKJAeTH1fyWy95e5oAv+sx8ykz3e37YDWBvehQ5rWfYmKJtKQ5U+D3AosMcj4N55FLVMayAMclL2NdlMUQwyFx1NzJB/7HyNAiNmJAo4d0YVcn5msoCSgJC9yvhTlBYG+bDqDf+H1ajzv5JBODocnxPfEis5DwzFkSKX1JCeutPKOj9Gjv5a3JV7cQb55LHFLjlG4MTgm1UOhc9mZEcmjQ4U6uy3SUMXeZH678VxSI6TQzf2T70tcOATuo76U7nqTSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRn3FAX6NcN9EtATgrBQE/9sFZmZX2mWn0FeYvXIZPY=;
 b=qkp0vN8vIBRrSN3WNlgzn8ccrBcQIsKD2krDgyJGgMEll7KWYU4hdH84FXm39XBHh9Y1efSUa6iMMIQSHU0L/9V+gVf7U7XjD13RKMsZxC+7TV4QCU/0Tq3j0ocExrpnjry+C2IFSRGfiMJKJpqMDf2vEkyUIgkrGF6xz6f9Pp3TiWNe4L4z3uwPfl5f6aPR5pBmdQ4ZjDFfRz+fqx6pzFAAZnK2l7+g/oiPkBPU95slVcCXI1fzjEF1m2T34NKMNqtmU5UPOSxpIe1S6i3PvcqDuGuVk3f9eJOkQ4XVd+cJzGhaqz9u3Oqcnhl3jANXKn4GzLUCpZNi0hKti4vdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRn3FAX6NcN9EtATgrBQE/9sFZmZX2mWn0FeYvXIZPY=;
 b=CrmT8MCkBpqja5H0X7ONMu+2FTu9dmuO30gvUKU+I531JmeHVfBV7d/OIzlgPRxK5LovyllmfXW70dphPDHOXQLHTRmjdKuyssw52dv4rKhykw6ugBjkhrPPE7939IlswQYtoPu4S+BrvuMSspj/iUvFSYknF2rg89nj5oJZsqmSEEztPrpTeL3xu/ikwZhLexWB/M31syiUq4iA7HUr3mfdCDK+kIOewZ2CqASTaHb+Vza6hajtwsj7BBFUudh5QFPgL7CvxN8aXKPOoX2cqby76+lSvF4k5OcKa8FR/xzGRVmHJzRTnFc8Rjv/9iCzCFvHpUxDbUUZB6bG0Q6cfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 09:22:18 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:22:18 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 0/5] can: flexcan: Add NXP S32N79 SoC support
Date: Wed, 18 Mar 2026 10:22:10 +0100
Message-ID: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 847009ef-c8cd-43b0-4850-08de84cfd9e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4RVRq9kud8PpLwWHVfTcTTWcMneV8iO1uTDGFh1Rx/5aUUQ0EKRC2thQ1QoSYCk2lYjKAQZ7nL0yKd8F1f/4xJQdzcKRHS4B0HPtbWskd/jk59aXMsIYX569EcnJcDGyJ4HDqfi2aZMOWxmn7eDeNhVizsrwWifoXjZzCxJ0D3hzcMPnf8kTPuKkcuaGCmkGCj4ytCTBJKNOnJ2PWhSXXT9OtLhjzm7sC+T1zPC39iQIbYEdsqVwS2YgL7xEBfHJFZrDdCS9ZdTkdTM5w/4Ekj7kINE264pKR2V3bGNHFpBphukdvY5GRrs30MNn8Cw13QGql1UDuF8ZxFqDRNEeMEHYCm5Y02Y+bgcJ3z2c2ETldq55UzIUJje/asoMEe7ddIEWdyUrMgTLx4FBOHhnWkO2vMzuwEikiznIysn3u1E0r2Cwr+cscktEHw8JZknbJFwAqE1ETI56XC4w8cNvv4rlIKb3sJD6Q6Ed8e7EFgLy4MaNhWklCQ9CWBZk/phRSaSvqcbPLW0493PZ76BoGRiT0afKXO37E+K1Zif6JKcefdDlr3K1erd+Ud+bd26AKtB0Zumm0ZNvhPAhJbxk8c8FiOXmncKOhXfwAt9STWkGyRpaoSGiefQkvcCarcLVXdHlxDAqUFn4fFMcsvNRw/+STK51oL9G7ZWI0L9ohDvflGR9lgVbZ7WcF3SKb9kMg1nMI+8bCYDccRlo79mBiPngRYuU68T6sldHkFgKgVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEM1a3ZQcE5RbldlWTJobDZLTlBWZkZtbnVWV0lWbWdleGpTdzBya3ZpbDcz?=
 =?utf-8?B?K0pUYWo2QUpMNm0xVGVVeG1NdzFSd3haYzNFWGtObkhFK2pMUXRSOVo5Z0lS?=
 =?utf-8?B?YzRqcndWVDI2dDlXSm9GREN4eFRBOGh5M2tVbmJYUlQvSTNyNkZZYXFscHFm?=
 =?utf-8?B?dlBvT1NMUElCdjlublJxQ09qUjZCR29FM3pJdXFpMHB5SWJjMGw0MmtKWEdL?=
 =?utf-8?B?QjJnSjNGclEzTW1nRFNxekQ5SG9aZkhQVE42SkdNa0pLbzV2Ri9sRTh0eFlv?=
 =?utf-8?B?MktOTjBLLzVCKzVOaTRWWmdIOU1obWpKZmNoVTR4by91ak9Xd0FTVFVrWmJB?=
 =?utf-8?B?RStnK2xwQUZKUlE4ZDlqSUNFakJIWWcrbzFQZVRCODc0SGpqZmRQcWlCVitN?=
 =?utf-8?B?SW5kNzhlbGVrbUVDY1dOWkE4QXRWK1UxVzlldXNWeEdKNUFGMTBsOG1XWm5X?=
 =?utf-8?B?Qm9KbVdDaUdLL3ZDKytjSXVoQVV6SHNPam9sY005VlNlQWZNMWhpVXpldUxV?=
 =?utf-8?B?cUR0OU1ZUm84N2RIOUFocDBJTDlMQ0tYS1RBTy8zNWdZemRickF1d21hZS95?=
 =?utf-8?B?UnNUaDZEZTdCcXlJaTdpZ0lIak5hbU5ZRktiUWNUMlkvYktSUGdCSUdsbE53?=
 =?utf-8?B?UGVlanVWR0labk9qeHdlNWFndnhKbUc5c2hVN1l2VFV0dGg4enI2TkN0UnMz?=
 =?utf-8?B?MTYrWjMveWdrZzMyVHZqbStSc01qakFEUGtZdmhSQkNkSUxLbllDWFY2alBq?=
 =?utf-8?B?eWtkbnVHMVVCVFh4SThhc0t2ZEtlN3Njczdha3Y4cHNkblVBWC81UHBrSStE?=
 =?utf-8?B?N0ZmUzJFVEpadjR4UGZscENaNE5YTUtOaUE3eDJBd2QvZStYMWJRTUE0Smxv?=
 =?utf-8?B?bm14L2prNzhFMVdPT0JQN0tzWmF6MXZkbGx2UWtXNEJ1SnFHbEk5a1BhS2M2?=
 =?utf-8?B?dHNUQmRrbXd1M0ZsaU9ManRPbU1CeFk1Q2lQUUlxWnVYazE4U2JhRzZrUklY?=
 =?utf-8?B?WXlQSW1ZU1Qya1hTaERzOERDb0R2cVZaT2FFZ05aTTRSdURJU3NJT2ludjIr?=
 =?utf-8?B?NkpCWHVEak9YdUQ0UFB5T3lPWXJvcmRsQk03Vi9oUUtscGJmV0piQ2U0VDZM?=
 =?utf-8?B?T0RmMmpFRitMaTVaLzNnblRBUU05TEYzeTc1Q2VUODlsQnM1aUdqVUtXUTh3?=
 =?utf-8?B?V1l1dmNpeUZZYVBCZHVia2JUVlQ4M2dLVVNucEhlYnBTeDcraFRMeGYyVG0x?=
 =?utf-8?B?M3NYK2dtbjhzdXB5YWczWm9ySFJueGR0dEovSThnUThkSDcySGk1TDNqU0ZI?=
 =?utf-8?B?c0FkUlFPMG9Tbk9PdWtsS0gwQmJDdjkxVmpzMnhTcnRCenorVlM0TFdiVkJJ?=
 =?utf-8?B?RzRWZ2lKc2pFcVcyeDZHR1R1dWJabkp2TDVHVFhEU3lKa1V1OS82djllUGlJ?=
 =?utf-8?B?VDBIc0hJMVpJVEh3VlJQVU4xWFJTRGN3UWZPT3hlc0pYMnhMbTg0WGMrWG9i?=
 =?utf-8?B?QXdkYXBqQ241bVFGdzlvK1U3aXZ3S1NTaVBjMlB5WGxya3AyUUw3RWlraW5U?=
 =?utf-8?B?QUVlUHVYNTZ0V21RYVFOdzlhS0F2NTY1ZVJxRHhiZmVWOGdXZEs0TzdBNTF1?=
 =?utf-8?B?VWxGeDFxMFh3RnhxQUtBckNTa0o2LzQ2QXEwbFk2UXZZTUQ0NEpoOWZJdFZW?=
 =?utf-8?B?akx1T0ZVQnZydWROcHdTVmgyZGdoL2ZaMkZpYlVoOFRCSEZ1L0VjeXdwM2hS?=
 =?utf-8?B?QWJVS0tPbVByN2pDZEJMUEVSaUpFRGNXZEU3WEtwcGtDU29rSGUxZ21HYUMw?=
 =?utf-8?B?UHQzK0hvb3Z4a25rUzVZdysyQkJiR0xrUzRkMjBLQ0lKQ0Z5N0hYcjZaT0lF?=
 =?utf-8?B?OXMyTmFKN2ljU09kR1NKMDBmUXVLWk8wTlp5eFlpNVRWZllaUVNDdWZlT0FS?=
 =?utf-8?B?K0JxWE5aT0ozVlg4b2tlN0Z3RUlhV212enRvanE2RFZXOHZIVVRLT2pNRUgy?=
 =?utf-8?B?Yk1yekNVWFg5TFIwZXMwbTZlWEpMRmlPVUsxbGdmNy9mVGN3aXlVdFhkdnhh?=
 =?utf-8?B?Z1Zid3lNYVQ1UEVUbWJVcmVJU3JTT1lScVRZdmpFNHVsUFgvZy9qcElLYkcy?=
 =?utf-8?B?dG5oUnZZUDcwb0VBbUd4cWlQQWZKejRBdUxaemROYVdPNzU3VDR2NGx6L1ky?=
 =?utf-8?B?UHZkekVUWEpvQVg3dENKZzNZdDZKRVJKMFgyNmdIZ3Uza3gxeUpZaVE5NTVy?=
 =?utf-8?B?QWpKTy82di92R3VKNmFRYkhZQ1VqdEJPVGR1UzB3VFhoQkJIRjJ0N3Q0emYx?=
 =?utf-8?B?Z3RuRFNOT2JxYVZMOXdNUHFuNkhTNW9ndHQxV1hEN0REcWN1S1U0REJ0RkZ0?=
 =?utf-8?Q?D6FbuhU3O0ShyYcc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847009ef-c8cd-43b0-4850-08de84cfd9e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:22:18.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rns9TkMozSJOUjQPAMbbrnR+bhlqOcBmE4z1F7IS9hBSiTUqx02zONSGVXro1eNsSDo+TOdY6fO8B9WZDbVIPPLoFhVJLhbu79sedBzsu4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7127-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 686262B915C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Adds dt-bindings documentation for S32N79 FlexCAN
  2. Introduces FLEXCAN_QUIRK_NR_IRQ_2 to handle the two-interrupt
     configuration
  3. Adds S32N79 device data and compatible string to the driver
  4. Adds FlexCAN device tree nodes for S32N79 SoC
  5. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

Ciprian Marian Costea (5):
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_NR_IRQ_2 quirk for two interrupt lines
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  | 12 +++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 50 +++++++++++++++++++
 drivers/net/can/flexcan/flexcan-core.c        | 31 ++++++++++--
 drivers/net/can/flexcan/flexcan.h             | 16 +++---
 5 files changed, 128 insertions(+), 11 deletions(-)

-- 
2.43.0


