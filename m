Return-Path: <linux-can+bounces-7144-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFV9NAnHu2kooQIAu9opvQ
	(envelope-from <linux-can+bounces-7144-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:51:05 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0742C90B4
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBD132D2FD0
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BEC3B7B9D;
	Thu, 19 Mar 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XN3g+/7m"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF03BBA15;
	Thu, 19 Mar 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913248; cv=fail; b=ry4PKUa3Dvyka3vzBkY7QRJiXdwKaGej8B0BkBUbJAbxYv5n3C6JUPOeqZYY2wjEWlaFYrbt7Fldn5LKaFvFFsaef+D13aCVoc06yclbpzKWxZqjKTD+RP6wUZiQ9a1xnIhIqjP4M3b7zCFTnctyuG8jMSK1W/rG0CQXBeGRlcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913248; c=relaxed/simple;
	bh=AmkQXFLaAgioZXQr+kr0ifiAPUfa04f++MCQqAML8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWS3/s32v+2rXDxxh7EbJ6Lz1PiXFKCkvhaQbmC5ofV31jyCc6nR+DyQpGqTzNyjs2rSgwHqaEzVUbUtTjvGtbsQ4ZNmTBJwcsePatgzGaP6MxW8Vkkb+HBuGxzhK7Mt959sWTlhC4jD6NhAGPomzvRyxFUh7LFeDq1lBxIrK5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XN3g+/7m; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiCNzqDGm82oJLGX54TlKu7NNu1tjtB0YXWGXeigP8SWtIwawi6yityot7bic0BxeLBi66pv6HGzG8d0VZOnAiCJE1u3CQ7GcHAPoNgqfgu3WiumoDstqgPd7xNPxfWkjz461dDfvSEXsfpBSv4prPGPIlDFtNUHIaTkWl+tBI5U98G16tX128RkGe+mjOayr7zghCsafTxVa00gyhb1SMXDXKXZp6ITe4eC8qH7hP37zgeRxcZd03jjbPQIcfB7tuCEmO7xcw03Q37mZPKLu6nZ8wNiT3ic9oiu4gnInG2IeJBad4FRh9xq9rJojSPIs9lM+XjgDMMzt0AegZkibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=JdUi1juFtCNZGToKxZp7GdI3j0JuysTS7YWqAbtS2e8+szDIxb2e2vArfXs9Wvx/pLPHR4eGQ/QwIGGbVwy1yBH+4Isd46QIeW3bV5Uccn8udMV1s5UiZpGKxcbWD6LieBhlLzGSQyY2E0KZlcAf4Mhn4WGuWnqvoI/kayANTWPnN+lVyo0bm9ZB36g5MEv+ejQ2nEofKQwLAjwiOPP4+gvnl4fi6mDHbV8lthW7esUA5Wwgep6A0XRmtjrw99SqOVB74ABw8WDGlDVbw+eJ1ufIq3JsyQ16c77d2vZ2AGqQ/iMUQC/W5NieOlrL1GBx4rkQAKTd5DBQ2kc5A0wDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=XN3g+/7mVMWK8U+PrLZoDJmP7z+JwHbBj8HGBWQC573LRWAU/r887kznO2BSciFhzTx6hz1iK+OTphJt6wMVqM1LWAlFl5EFraFje3vJzleByJngFLvLxb8D60l04zq4U8flgp163a61deHE9d84R2P5tzi+oL681Ss0x8Rjsyf83/Jkq7yyxhGctWSHNi8MRTByXrB0YhN6RJ16SvpqUbM3N2HgxmSrnlNCUVvJ9uWuUkTsPWAKZIB/ykraJTMUozKMZqf2KYFIht/Ngl5VIciX33HasquiLi7Z5PEwycwD1ROYbsBxmR61kwqwOcRDGn02UT9P4DJhIzJLDKwhaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DBBPR04MB7801.eurprd04.prod.outlook.com (2603:10a6:10:1eb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:40:39 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:40 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH v2 4/5] arm64: dts: s32n79: add FlexCAN nodes
Date: Thu, 19 Mar 2026 10:40:31 +0100
Message-ID: <20260319094032.427697-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DBBPR04MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1cc80b-702e-4aa9-634f-08de859b9526
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PeyWj1miHnDMdahX5Uc/B4tC+y1gWgqq+FNpjCVOX6QLwpPb2o0wIgft/XM4J2aFX5+W51O7nl+gHGYdJ9Ngi7PE2qBJju3lRSIL3nO7XmBIK9lRQirUcnfrV9UW19KFY2KJH98eBIrjGAYXHZEZRVB/fWvN7qeRIXzpP8CmLLHp9ZZCA8h5oH+ewuWuIWPDSxsumLLATmdnQ+MGAiYH3HaqFxQvMB/0TI0XfgoDaV4py0ANT3NftE7jbXOEZuieB0JQXFfzRZ8jgPsCEWhJtfaunsWdEpVJq15W+yB/bKa+OLJzKw7sSEpqPNVUQAqAaXlnX+RNljXQh/sMrYJc6gm/DHE/wVaa7jG7PTIEwIDnicv/1V9ukQ7lIu6aLQKgSGZNn1htUqxCbrPW5XKvqhJgbqI/IFwDXZ5OKvSZILGJctdQZeSLKIroq3Ezz8G54JN99RNBHWs/e0dkrK5rzw88Qd17lZ+TdVF2QvUxCUbfbjifTdV/WLT3cR3cSufHux57wFd4VdNK1XO8y9A4e9zW407PwUY6A9arXchkXoSPV5yrBtRGlPeLOi3PxBCreOksJxWlNyaLHbUFhxqdA4mC1/tsGuzmVf66YjxgvsoLLdl9vLSFMNQ+etEqiKWStShDVzPrLjdwlFDjJ0bEmj6Jbo5rwGcwjI4VOBQYYRxKg1wpky/g/Ntm10iWQNk/jQTvuDRs2jwy637bFQKX9rWShQohy2NTXtrG32q0oDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXFSdXZ1RzRmcXpXQWF1Zmd3TG5hbWllRlBEVXFVNWhNOHo4dHNCZFVYZ1A3?=
 =?utf-8?B?M0N2TkZjdkNrLzRQVjhkYTBFMC9BbWpkZ0dRczFoQTZ3TFlzSHM5KzBxdEpP?=
 =?utf-8?B?VG1FQTFiTFNtWCt0Z1RmTnliMzQ4NWdML0lZdVdDbFp6STZjS3d3c3V0V1BJ?=
 =?utf-8?B?R3hIbWpzZXo0Z2pOYjdIRGJiOUxFNmcxMm5aODF4UHN4RXl4ZVNXNVVReW1k?=
 =?utf-8?B?NjVFa2NYSGRPT0NNOEpaWXFzVkprd1NhVnRiQXB5MTJOZXJDVWI5SWgwN0hZ?=
 =?utf-8?B?Y1FoUnVtOWFRUkc3dll6Q2JGbFNIL01SU0d6OFd2VG9yNmVML2MwcThCMkxj?=
 =?utf-8?B?OSs1Z2ZIaGJJUStGM0JZT3IvYWZaYllBWWZqUVM3c3RNSXNldVR5N3hkQVY1?=
 =?utf-8?B?b3hPMXB6ZnMrYTJ1ck5zV3V1N2FWQUlXd1dyb3dyekpad1ZEMG5ZQU1GYklJ?=
 =?utf-8?B?ZGdkVlFYMy9kdEthNUc2Nlk4ZEhzSUkyQjNJS2NmWjlJejBkY0FVNlZGZUxj?=
 =?utf-8?B?Mm1Ma29FSjZCa0hIc3k2akRxbkk5WnI0YkhZTEFCZ0tHVTk0ZTBRUG1zcmR3?=
 =?utf-8?B?Q0ppdmlVQThVVlN6VlVvYkYybUJGV3ZxNUF4ZGdCVzFSL2g0cWRwampBSC94?=
 =?utf-8?B?SUE5TDhCa3BxcDdDSDZDMnovdTk4emM0c0QyV1EzaHJtLzZ3b2tja3NlRjRr?=
 =?utf-8?B?bXk0SVNKYlhieldpSmdSQnFsK2F5U3JteC9WMnRLalp4Z2c4ekIxNzQ4Y3hR?=
 =?utf-8?B?cVJuZmw3M00zNno4M3FxMEVzYjV4dllQUlJWdzlZNFUvTkJ1Mmlsb3Vvak9u?=
 =?utf-8?B?bGx0bkVWUWpOVU5tekdJT01uV1ZaRFlSVGhJdW5XcHlWQjZTU2UzMGNBdi9F?=
 =?utf-8?B?Tnh2K2NBUzBMcFBBRUJKODExeU93d2ZNZ0UxaTN6MzN6RFFLaEw4Mm5oRStP?=
 =?utf-8?B?ZERLc0FyQ3NuSEU2YUFwVm5ua213UDJBYVZtNTE2cHgwWnY3Q0I3QW1RQnhu?=
 =?utf-8?B?MTAzaFREbU0zM1NGOWRybWwrV0drSGNDcHlhaDJmQi8rZGpCUHN5RlpPRzl5?=
 =?utf-8?B?R2k3VG5MRStxV0JZSXNrRE5mS3VZSDA5a0JFU3J6R010Q0RLOWlIQjBqNGxr?=
 =?utf-8?B?M1hvZUEwT0NibTV1dXEvTklYay84NWZQYXJSUEsvLzJDRTNzVFJMSk04SGN4?=
 =?utf-8?B?cERVbXhRZzgwNFoweE45MkZ1MnBGcG1BRmVCVFd5MWxHdk91dUlmckhtOTBu?=
 =?utf-8?B?bnl1bHdwbGdHUitIZUlHNFcyTVhpUkd4c3dYei9ZRW5LQnE4YlRTSlpiRkoy?=
 =?utf-8?B?OVRsdk4rK2VSWUJka1hiNGI0Z3lma29MUEw2ejRwL0x4blB1MzcrdXpuNmRS?=
 =?utf-8?B?ZnZvbFJjL2NBdkxEVU9NOFVUdi9qWTFVcTBVUjlJQWZpczhleGdvNEhEQWtu?=
 =?utf-8?B?OVJGVU9LSGFYYzNuZnlWcHI1WmFHMkx2NVNjOVFkUWEyUjM0dktUZXduQXE1?=
 =?utf-8?B?L3psRWNod1VWWFVIK0N1QjVBYVFvSG9RczFJL0FzR3VwUEtoT1M3NE1ZR1hk?=
 =?utf-8?B?NFkyNmYxbHcycmNSU2Nhbk9wODI5c0lZcE04U2tIdVZyenhJT3gzR09qeXk1?=
 =?utf-8?B?UVlJc0RweXV0QmpITmc3anpLMW1oWk5KL3RVOG54cXlwNENyY0k0dENIVnhw?=
 =?utf-8?B?Z3Z1Vi81N1ZTWXZQR2RNUEtHUThoVmFyck9xN05wTjF6NnBMMndVY3VRaFZV?=
 =?utf-8?B?Ny8xV3U1VERqZitiUVM4Y3c1eUZ4Rm5GbW84OVZHTk82QVNiTHRxTVphUzBo?=
 =?utf-8?B?ZGs2ZXVjNCtLTm9ybHgwWWE5RVBLYmNES0IxQ0NtNUdpeHVDR1F6VnZZZ0xp?=
 =?utf-8?B?Y0dVZVlyVkh6Uk13V1Z6d1FNK3pDcmZtWmROeDZYd1hCcnVaSHdMei9renV3?=
 =?utf-8?B?T1BnWWZ6QWVnaEZZSnVPQVIrYkZDd2xwRFFsN29nTXI0MDRoZEdsRURvYlZN?=
 =?utf-8?B?VFh3MTBUdkJ2YWpUZDNzVVM3WFJaaWc4M2NJcHRBZ0NEU2wvOWFNWjNuUEVT?=
 =?utf-8?B?UVJ3T1Mya3NBWG1GQmFVeTcvcVBMTTFTQUlvTkQyQW05Qmk0NGhlQXV0UUg2?=
 =?utf-8?B?UnpOdGRIMmhYMVdlay9hczMwZzljZ3JaS0hIWEVzY0kyZkVVTm0wQzVlcytD?=
 =?utf-8?B?SkJyQXo5QTNXZkFKdnQ2c3pScU1zeTBEQk4vWHBPYXNXbG45WFNmZ2J4UDZY?=
 =?utf-8?B?bk1iMk85UnpwMDZScnVYMjlNTWhxK3RpZGtSa1dDZnlqcUhzWUgyd2xVNWRx?=
 =?utf-8?B?WGkxeFFDUERXa1Urb29KSXFrUnBuY1Q5T21GY1JCMHVDeG5DN1hycjc2QWFM?=
 =?utf-8?Q?JAC+N21zf7DINb1E=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1cc80b-702e-4aa9-634f-08de859b9526
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:40.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SaURFBRaCYlO8m4TP3h0b6Mog9vaMkL0e1fF3XYbT+X7Yox0HLMxZ9jle38BSAxsTstxalUVXb7IX+eNlAhFSZY6Wec7TRLeX/8XV6ZYrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7801
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7144-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,55b60000:email,3.72.198.72:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 2D0742C90B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


