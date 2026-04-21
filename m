Return-Path: <linux-can+bounces-7384-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAHBOEBR52lW6QEAu9opvQ
	(envelope-from <linux-can+bounces-7384-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:28:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93992439819
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ABD9305DD1F
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D33B9D94;
	Tue, 21 Apr 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tGWJBjGc"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EA3B8BDC;
	Tue, 21 Apr 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767181; cv=fail; b=VhGyWLwSj3tV7/eV9sSqko2sf6IEu4CAQzWUWveGwr5xdaSaQrQLMRWpFs1s/Ubryw9K6E2pVV5yFt5YyN0wv3ZRC8boYV2NFhwiy80Jip0btqktbfjkWWIQ4NqN2hNkZAo+oeJxcn/YEA1qq/F2c1ZsCZTNGySAtmEPwj02scs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767181; c=relaxed/simple;
	bh=X73y5eKmEDXMZkOeid41Y9oWjpHvGp3eMNcJyEOVYYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W37jHzEelqp9et11tmnUIaVw3l91leeQTJh228RwTuBdYExpAh1X/BJqlAfvEI1BMbphaN25vm4eU6g1YQrVJK7B1fJQnLWoBDaMfQ7PAQ/haN8I35JRa4NSAdymyqZCSvJ02yRHdYfAxXbTdYId2fYw0lFru0MO5FLSnHqmUpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tGWJBjGc; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeePn6UMVaAUhD5Qwg915FKL3En2dVb9c7y7N5YqDRiTkVu88PYA0o0U5a/D1L5qOGQFJgQvc8c1/8R+lWanHtDibDZTkeENZcmqFBuTC63QNsKz0As6+GHdbUtEI8eqZNvBEv/uQwPt3c9aycQ/PXC3AnIF7pDHxN7DQWe4UnlLt5/QoV18UkumeTrpl/Jkur0EixG3uuWSCFnwjwRc0+SnBJAQ8xBbNbwJBSktc3s4m5ZOPWLJHOVkIEMGLdcYZTBjeQJD7sDEtPJz5y4gnp7hg5U4Hg2vwmJ9mr4mVNzO/f0snv1wtQVYZ9VFqEMWMJMJUA3i7AQe1nLoGTZrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZzABiD+Y9NW4W0IfLoq3EPHnlZMdPk1rCC0LnYNhQQ=;
 b=V6qC0xYNAK2XN77W0jr/i0abkc6S+8P0ZqoQpddNy03HzcCbOWu1h9yLKTV0ZESK/cNFh3mFkvh6cLIQTJi5/RA52v7z4sQYU3svs0Xgi4/LOiQEQ08h/owMmvOe96dab8e/wGuAGyT9bJQ+lfMdOfSbng0hsx0SL8OnnqT3+Kw6N5oPTcskrp96ArMCU9h7d0SHiJnOTIdC2vDctYtU6g8zlUbJSheI/1Sanr9AuHegO54cICs/vXM5PwbdD/gT9+Dgp1vQFEqSPuV+x72O4VbyUuBsPQxM+DJFtTi7uXYmef7rCMi6HiQCCKfKA4EySDb0f1s9cB4MhaD4y/ULlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzABiD+Y9NW4W0IfLoq3EPHnlZMdPk1rCC0LnYNhQQ=;
 b=tGWJBjGcHn+3+sSUCraorDv8S1kkML8cE1A2YqoZ5WhShugt6wpcLQuDFGnhjoz39plReY07+Tc21Tew28XwkhsLVFBftXx0rC1V3dc9HL445b3SPn4N3H8+pI/mimqH+iFmUqHzQLMgLZpCL2PQqDuV8R8QwCa5EFeGGM9CZMv1sv58uTAkZW7Tq9PjiFkGVETZiP32zxesB3d6hlK2kIgneRITeAhNeQps5IfuLw/902CK8HDLidx84jYoHkwxC4XsaWYxbxrpCvGui3yAhQsCkiL1NdA/q9lVKL7t4mKZCFphhWLU6NARcIKTQs+BM+JUkeq811PjZ8VkYXHJHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:10 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:10 +0000
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
Subject: [PATCH RESEND v4 3/8] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Tue, 21 Apr 2026 12:25:58 +0200
Message-ID: <20260421102603.4122332-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e5a92-a51b-4196-d0a1-08de9f906815
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 1E6jDWlFQUt+TRyoNniQNQGkMykS1Rs0f8EXvC3news9S45joyi7R6VNq+fpS/1ajGzP5OeUVOm7ICTngmVtUO62CZ5BnjKr9//F0drtj79E3+r7+GQb5aC4kJtVo3pkr7w9L7HJxZC7cGVTWgHqfiz1jUL9LQJ9brihRTcX6GfVb+zcu8UU67nDQcIsTEZQ/Mz56MH8VL7e6STIfXMNhB3hU1gq0tONEeOpmKU81+cmcdYHCrdl1gAcigu9pu7wIP5ZfOaIRiBaGjeeIFwNuTwb134r+QMTE/o8XH2HjyxENTwztPyAVN5IuuxsEl3RZq+fHo2ObkbRCkBNUjdDvfg047zq4cOCAKrAq9DVKvpLA+p5UBZNG/ls6UMSjkhhZ//1nIdJSk0YXfAtlLsDDskHKJfzNVZ0/IRvSC9yHgcP8cL01qkP8cxPRDtrDN9joJbTBxs+IvvmneqKQmNYIaOSDdcMR6fes8r33hyfyeCIiv1b2q3r5r5GxMR6KW7oYnE796GxK4JjpwZv6hvTr2SYCPzGGKzhj9YgVw6HnmBkMyQX3Zznr5mGpdwpxUuF2AWhXNzaTEMeRmK2n7aIREOQs1VH04lxgTwn1ZGHhwD2ZwgYPEXN/o9XxnujxoZr3r4Y0I6bAgGyrNBAwqzZvU001nElLjSGJC058UXisIp7P2iIgsxhnEhkF4GbUKDHaurZ8DkrRMba4pj6RZAfCSCE28XasJVg4xwK3+XQ9GE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?emdTRnFYWVRyME9sRXRrN3NuZmFhSGlUc2RwRGVRa1NZdmhES3Q5R1JNRXo1?=
 =?utf-8?B?aHRmTWhwYWRyVVM0Q0hWWmRhaG5hZUZmczZxcGN1M0xOc0o3SWJNc0pBa09j?=
 =?utf-8?B?NjBKaGw5VVl0SitsOVdsYkZVUWV0ajlTeTFUdFVDbFkzZi82TmNnYmtUN2py?=
 =?utf-8?B?OTdkdWhGaXpjTTA3ZnQzTmpXZ3hsb0s2Y0lWQzd5ZHBsN05KUW1KZ0ZzckVi?=
 =?utf-8?B?TWI3S253R2RnQS9zZU5BUHpwMHZrTDhEY3NqaXgxaWlJQ21Dc0RIL0hxTHJi?=
 =?utf-8?B?cndvNFByalM5YnRQYlBLeWNzRnJCaWw3NDJEZmFPSExOdTNYYlAwdTRzNjhL?=
 =?utf-8?B?L1J6azd4ZFo2SjVVRFJKRXA4ejhjMWlXR1cyN3lxKzBrSEFrdERXQzhzV3hs?=
 =?utf-8?B?RnV2RENDc0NvMnROT0d1LzBPQ1JyUkdPMTVJME9aVmhWREVnVkdaOWhmT0Rx?=
 =?utf-8?B?Y1VyTnB4NlBDV2d2NkhnckhNVWVjaVFDaEdFd1hzQnpWcThSaGs1cHJnbWsv?=
 =?utf-8?B?eTZlemlRVkw4UTBRcjAvVTF2a0g3eG5ZRW0ydDJPRi8zNHNrZFpFRUh3Tmll?=
 =?utf-8?B?cDRFWkpNRVB5emJ4NjJqSmEwMmZnYkx2UEQydEdOZTVBN3AybXpSRzBoNkxt?=
 =?utf-8?B?NWk5MkhvTXl3V2YvZHNoVGh4Q2hiZ3l5d2JRUGdmQ1Fmb0h3OVlHOEsvSHJ0?=
 =?utf-8?B?WXdLK21WS2VTQU04OExaL1o1a3dYUTl4cERQd0wwUHA3bFRKa1U4d2RPOGF4?=
 =?utf-8?B?aCtaQTZ4bElneWMvS0VXTytNY0RTSzVNL0d2RlFhcUc5dVNqVTgzWEhpSFJY?=
 =?utf-8?B?ckZsSUFJc1NXTmU0OGRDb0w3QlVEZG9la0pYZFNuRlJuYXlCQjZnN3hWNGMw?=
 =?utf-8?B?VXBEai9RMExQMHZBdDBRTWx5dHM5c0Q1TXlpR1prbXYxWUVkcVYzOUtlN3lv?=
 =?utf-8?B?MkQ2ZVVIdjJodFlwQXlPSUd1WU00eFNldHNSWi9KQnVWa0FoTk0zdVduRU1s?=
 =?utf-8?B?clhmTGg4NHoyenFhUUw2SnFzcWJoUWNiNHQ3VFI5TTBiWXZPaWZ4UTFZckpI?=
 =?utf-8?B?WUloVU1hdlBBRmNYT0t0Y1loRjFtMDRzVk0zQThCTzVqT2d5OFJxUnFMUVpo?=
 =?utf-8?B?VURyMkxSdGZ0dlM3R3FwYVpCUEhtRVFUWjNCcy9QT1IrU3NZWGIrSURaOFE4?=
 =?utf-8?B?d2RwT3ozYlpQc0VzVHc4cVhmaVhYNktxNWJGcHRCUmlvcWlLVmdsdnNqNmx4?=
 =?utf-8?B?cElaVERqZzhpOENOdVJTR3lrNzhpUnBqdzdtU0lZQjdxa2hUTDJ0TzFvL3c2?=
 =?utf-8?B?UDhzcS9FV0JQNERKVnV1WUxkZ1V6bEU2UEhYa3Q4dGE2VG1LbnhqMWpZR1Bq?=
 =?utf-8?B?c3ZlUkhEWDI2SFRaWGg5Nm1tY2FVMG1wd0VIR3BUcWdCVmxYdHJCdkdiVlh0?=
 =?utf-8?B?UkNNM1kvZ09sWm9naDN6R0RCcXZnZ0ZtRExiVThvVVVNakNtRTU0YVF3M29u?=
 =?utf-8?B?T0VZK0FVYlV6NDIwRXpBK05Ka0pCbFJHRkJPcjdHaitsS0pPUXl5NlY0TFps?=
 =?utf-8?B?cy85M3R1ZlQ4TWZpWWdJV256Q1l0MHhrMU1QMmRrZVAwQmdOMWV0SXlxcXVC?=
 =?utf-8?B?bk56UjNzWkhDcDdyN1UyTzVJZDEyeFZiUlU0RDZjQmhUMlNVRXdwdldnaVdw?=
 =?utf-8?B?RVVOU1dzaFVQV2RmdWtFNCtIUUFHcURKZzJqQllkSzkxY29UMzYvUmthVytS?=
 =?utf-8?B?VWo0aHlGendMWmVMVGltVWRKcVh2UkkvNXAzL0RqUUROOEtrRVJGc1R6K0VC?=
 =?utf-8?B?RUFRbnpmUVA2RWlKNUM1ejBDS09OWUF4cCtldmlsTVd5Mis3TStlQVJnYXk5?=
 =?utf-8?B?bVAvWnozV1hCTmFOcm1BT2hyY0tSSUR1dFREYll4M0o4NW9oemt6UGVrV0dP?=
 =?utf-8?B?ZW9NcUpmMGJOaXRtT2EwaS9ZMFJFRnpSLzMzb3RMbERLYXowbGNqakdjSTcx?=
 =?utf-8?B?d2UzaEpDbzN4eGM0L09HZWUxUlZ4aUl2M2ZJSHhlVjA1L3pFd2tPQmpScW9o?=
 =?utf-8?B?aDk0dnFUZlkySUVla3lCalhRRm9JYTlkRUljWGZIbTdrSXJsRHQ5WW5xRTVt?=
 =?utf-8?B?NmVNQW5mQm1ndFlzT0NseU05akg5VlcxY3BpNzhrL0hkeDdYbmw2RU9UMnlH?=
 =?utf-8?B?c2ViWTlsWEw1ZTNOLzZ5M1FWSUtxYW5CK3R1RVE2ZnJJWWNvOHpyTWxIZnZL?=
 =?utf-8?B?UU5DeTVxbWNPTHNNYjdhUDhnUXJHZ1RtanRtc1FCemlFdVVPMU5DS05hMW9n?=
 =?utf-8?B?SnkwdHp1bmdqbnRRbDYxaVB1YSt2ZzBaYjg5Nk42V3lMUEdWN1pGdEdpajh2?=
 =?utf-8?Q?MJXcPZtUjJd7zNeA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e5a92-a51b-4196-d0a1-08de9f906815
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:10.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKujLEJoxvBdBypY2tDCq8CalN4o5GB2NaCrZqGmSof1D9Ei5cAEGC+cWS8B5wVxnn2NFLWKVxGQJPZKzoLj2vHqOJInlvBQ9sXDniJ80ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7384-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 93992439819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
for MBs 8-127), both handlers currently process the full rx_mask/tx_mask
range,

Introduce struct flexcan_mb_irq to hold per-IRQ-line rx and tx masks.

In flexcan_irq_mb(), the irq argument selects the correct mask set: the
primary MB IRQ uses mb_irq[0] and the secondary uses mb_irq[1].

For single-IRQ platforms, mb_irq[0] holds the full combined masks with no
functional change.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 61 +++++++++++++++++++-------
 drivers/net/can/flexcan/flexcan.h      | 10 ++++-
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7dde2e623def..32e4d4da00a1 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -957,14 +957,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
 		priv->write(lower_32_bits(val), addr);
 }
 
-static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
+					    u64 rx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
 }
 
-static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
+					    u64 tx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
@@ -1071,7 +1073,8 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 }
 
 /* Process mailbox (RX + TX) events */
-static irqreturn_t flexcan_do_mb(struct net_device *dev)
+static irqreturn_t flexcan_do_mb(struct net_device *dev,
+				 const struct flexcan_mb_irq *mb_irq)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -1084,7 +1087,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		u64 reg_iflag_rx;
 		int ret;
 
-		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
+		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
+								 mb_irq->rx_mask))) {
 			handled = IRQ_HANDLED;
 			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
 								   reg_iflag_rx);
@@ -1110,10 +1114,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		}
 	}
 
-	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
+	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, mb_irq->tx_mask);
 
 	/* transmission complete interrupt */
-	if (reg_iflag_tx & priv->tx_mask) {
+	if (reg_iflag_tx & mb_irq->tx_mask) {
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -1125,7 +1129,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
+		flexcan_write64(priv, mb_irq->tx_mask, &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -1228,7 +1232,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, &priv->mb_irq[0]);
 	handled |= flexcan_do_state(dev);
 	handled |= flexcan_do_berr(dev);
 
@@ -1243,9 +1247,15 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct flexcan_priv *priv = netdev_priv(dev);
+	const struct flexcan_mb_irq *mb_irq;
 	irqreturn_t handled;
+	int idx;
 
-	handled = flexcan_do_mb(dev);
+	idx = (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
+	       irq == priv->irq_secondary_mb) ? 1 : 0;
+	mb_irq = &priv->mb_irq[idx];
+
+	handled = flexcan_do_mb(dev, mb_irq);
 
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
@@ -1473,6 +1483,7 @@ static void flexcan_ram_init(struct net_device *dev)
 static int flexcan_rx_offload_setup(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	u64 rx_mask, tx_mask;
 	int err;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
@@ -1494,20 +1505,35 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_FIFO);
 	priv->tx_mb_idx = priv->mb_count - 1;
 	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
-	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
 		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
 		priv->offload.mb_last = priv->mb_count - 2;
 
-		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
-					    priv->offload.mb_first);
+		rx_mask = GENMASK_ULL(priv->offload.mb_last,
+				      priv->offload.mb_first);
+		tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+
+		if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+			/* S32G2 has two MB IRQ lines with the split at MB 8:
+			 * mb-0 IRQ handles MBs 0-7,
+			 * mb-1 IRQ handles MBs 8-127.
+			 */
+			priv->mb_irq[0].rx_mask = rx_mask & GENMASK_ULL(7, 0);
+			priv->mb_irq[0].tx_mask = tx_mask & GENMASK_ULL(7, 0);
+			priv->mb_irq[1].rx_mask = rx_mask & GENMASK_ULL(63, 8);
+			priv->mb_irq[1].tx_mask = tx_mask & GENMASK_ULL(63, 8);
+		} else {
+			priv->mb_irq[0].rx_mask = rx_mask;
+			priv->mb_irq[0].tx_mask = tx_mask;
+		}
+
 		err = can_rx_offload_add_timestamp(dev, &priv->offload);
 	} else {
-		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+		priv->mb_irq[0].rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
+		priv->mb_irq[0].tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 		err = can_rx_offload_add_fifo(dev, &priv->offload,
 					      FLEXCAN_NAPI_WEIGHT);
 	}
@@ -1531,7 +1557,8 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 		disable_irq(priv->irq_secondary_mb);
 
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
-	reg_imask = priv->rx_mask | priv->tx_mask;
+	reg_imask = priv->mb_irq[0].rx_mask | priv->mb_irq[0].tx_mask |
+		    priv->mb_irq[1].rx_mask | priv->mb_irq[1].tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..22aa097ec3c0 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -75,10 +75,17 @@
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
+#define FLEXCAN_NR_MB_IRQS	2
+
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
 };
 
+struct flexcan_mb_irq {
+	u64 rx_mask;
+	u64 tx_mask;
+};
+
 struct flexcan_stop_mode {
 	struct regmap *gpr;
 	u8 req_gpr;
@@ -99,8 +106,7 @@ struct flexcan_priv {
 	u8 clk_src;	/* clock source of CAN Protocol Engine */
 	u8 scu_idx;
 
-	u64 rx_mask;
-	u64 tx_mask;
+	struct flexcan_mb_irq mb_irq[FLEXCAN_NR_MB_IRQS];
 	u32 reg_ctrl_default;
 
 	struct clk *clk_ipg;
-- 
2.43.0


