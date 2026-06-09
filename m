Return-Path: <linux-can+bounces-7784-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRJDDeYlKGpb/AIAu9opvQ
	(envelope-from <linux-can+bounces-7784-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:40:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CB6613EA
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:40:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Ljmk4CQ6;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7784-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7784-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 417693118F46
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849935675F;
	Tue,  9 Jun 2026 14:30:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698E3546EB;
	Tue,  9 Jun 2026 14:30:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015419; cv=fail; b=Hz1nRKrXaNeI7oKj7unhGnS3zsGSQlfY0JXTKAeQq5Gu4IGiwwH0/27h5+q//EF8S2rY25FIJTqeagP/4IW1DyUJREJnUP3iKp0fAie1RSCkGkazk49/qRpxxbw6D2OIjHbvCZrIenJ8qskjR+4lJouEbPPaHIs+J8sT1BaXBb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015419; c=relaxed/simple;
	bh=kv2gcVZ98IZ1droNKSUM2CVJZ83nh8WhhAcQ/lM35Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k0XPQZYMLOeg4e52NpMU/l1HEoPo5rz76zeEGiuB03ZcPDuk9wCBP+6uJTTo80/Rb5DI6tNq/+GHuaMZ+6+3WyL0P+ItaGfSGP+IOhmV5fLmfdrgQ/jHpcGb/SuI9jdyyA1seFA3kNg4O3jdl+QBDHY69HEGvyS1vIM+BJU+8gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ljmk4CQ6; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVmGZJBXR/CTbAM1NmG+Z8fevuW9mlYCBoYByshIGwr0zTpTP8DKkYpyeFFQaS1NCHdJdxf3G9pHcyznRViNuihicz1tZO1uRmq0u8rQsdJOOblmRI4Oi+JgrsQ7YZtkUFxSlithrkBE9NYgWt0u6FFRlThtfy+dBQJ01j69lp7L2aPGcAuX2IvpiQM7pPzTTsS8i8lQ4z5oi6BloCwF+EQwB5dPMYdGvvOMgplDFHG4xgQR1R7l35HYCwZc8DwsVGFFtMnb6rVqPnH6h/5+TqOJ2xuT+j7XJf4SQLnIbUpcQFrko/XE0ankNNlbvCDEYOCx1POhrCNDzfFJbNm7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHS9S/v3+oyAtUL/HuoPZmv7hIToiahgo2YsiFuzBLY=;
 b=yHWbfmUrV6cVEaCda98CbTZ7o/p7sxh9/i/KLnt77fqRsGv+U5nsGB32iRTU7qgiQQKCHvJG53lIV6vKmelgf0EKXnSmKVKX+4gIvdrsbyY5lNeIK5nTgywlXYZrLN01R9gVtwkJZx5Jt6ucJYozeB/I1ofs/4Tjpf17qA6S83LY+PFLMdkjFZ4Mxqb13un9GC6/SC3qufK4p7N+8e6Z2AktaQA9fGK7s5KshM3rB8RnhVaXJoLo2zg1I6LMQv+2salNftNQCzEJrxsPmxPU5m5+q8u6Nq8xZTrHqRN1xMLyznTMNwi290QydBrRAcgKHxUjDIC1Sz5YVTjwq0LRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHS9S/v3+oyAtUL/HuoPZmv7hIToiahgo2YsiFuzBLY=;
 b=Ljmk4CQ6cy+UKviVKgPgitC1foiWaSeYj/Mm2Jh2bFN1vh5LHGF5UV5zpQd3dgoE7oCFXAKYDWLJG/4pKETMj2KE0HZ41sbeE7BN8GEg0N4vOgKMJyCfQ4Bhr2zQKZAmeF+gJ5le/sZunSM+pstTcWkxRzdgw+qpynhy8ImcZftinZh2FF3ntzBxCAL5B/9Jyf6NMIWQx4zhf+FEVM/LsolL+eRLm0SjUN2xd9kzkjHDzyH5hLrygHU/VZU6gNr5FUaLn8NjL7VK50G8oke8Zed0X+A+LH7Ba6F3VklBxD6zzJx5Blw2Kp91Oo+8MRF7WlMIu+JK+a2qbZjjHKKrbw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:08 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:08 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 8/8] arm64: dts: s32n79: enable FlexCAN devices
Date: Tue,  9 Jun 2026 16:29:54 +0200
Message-ID: <20260609142954.1807421-9-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: f6aa9e16-4fa1-4dc1-3829-08dec6339b6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 e1hdITRvNvt8E2ug2H0Ok/iIwISALlFbPjoZ6yyc/HCs2nDMuc5EhxKMzdxro4xEldyggac62ANYGaPZXqKpma2nYILyoGFvNDG8gP/R9hx5pIWfuAJLTcI8clcR1xLNyxVq54XsBtl0ZfXi1L+hZOCAGLVE9XhFFLioXAb9QXtp+gmxVafs2LOvmnFtdfR40AWn3BxJDwa+JJZhUe4URnTmtKPfa3oExp72ZvkTHN8LpJb0OLyPgHGzgp77AVQTIsxm5q9DYWGjxBzKKcjB/3dcufQLoRlG+Rb/TE0cpJxECoHmG40DrERekuU4TLkHMiY0FXdmu2j0YPdmJA1HBP+LPvNoEG/jVXUJIEu+QgC/B1P2iHsprxaF/XbLDnQTta42oIHARljj2b5GKmgYu9E3j+Und+yPhXZagGHYQ/Be3LfFaJSu0LY+gvIyPSywMSMM5ITJEyoXCMbk2fCsoYeetm1pox6CgZJx4pD2uDGVfoi45+wSPXsTz5KUBcwRk8AElqgJ6Mii19Wv88tWj+qg/9QnYB84sfbsKmticGKc7kyEUL07fZEW9R5tIeHlUPqeyDd5frPIp32atzomY5HZ7KOa3E8kHgd/MZFwMr6xAdwPSDssTl5DCLDLqNihhhbW0aZAtGicX89/tCIkSHxBOmJjM3UHYK28K/PYp//jMVTkVxjQE63oYZk+6zpn
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U2piaEgwTFFCeVFscUt1cHhGSTBSY2NiaHRpRmxkSXFOOWlSWjNFVlFuOG0z?=
 =?utf-8?B?M3pjMUFGWXBBMUhJdzg1Y1hHVlUwQ04zMnl6OGtjd3E5RWRnNDlPeU1yem9l?=
 =?utf-8?B?b0NUUS9iazc0S2NWSFlITUljK3p0bGw5UGh2bmNOREp0VXVZTGdXNy9MeGdB?=
 =?utf-8?B?U3BtQkFqK29RN1FOd3lGTDRJR0s2cWE0eVBLNkJyQ01TVFltL0FpUzRUcGtK?=
 =?utf-8?B?RTFXNUtZb1k5TVBRY0dKY0NVZy94ODhWdEh1U1dXeDVYY3BtRlFzVHUrTzdo?=
 =?utf-8?B?Q0tLUGdFd3JXbVBmc2dPMUtqM3dQSE5ETUQ5SG00ODFZMCtsSlpDdDJQQTVh?=
 =?utf-8?B?dVJVWWNLdVZ5NEdUcHFoSW9nVlFGS1RZZFp2SDZ3NkZ1anVYcFZqMElPd2ky?=
 =?utf-8?B?WVhGTjlHTHBxbkVhZE15bC94dWptQUR5ZkhwNGlqcFc3d0xtcGk4UlQvVTJK?=
 =?utf-8?B?UGlVdXhRa3dVVzFESjNjMnExbExJUTNUUFZuQ1UwTVc1MnJ1aEFCQkdVZ0hv?=
 =?utf-8?B?ZE5jNE5qOFhXazRUbGRndHJWd3ZoRWhpYjdZeFdTWnQxWnFlWGdoMWwxSUwr?=
 =?utf-8?B?aERwL3pyL08yK0JVZFM1ZXBobWJmdTB4M3M0VHhJRFNxVG1JS0ZwL0JCajJ5?=
 =?utf-8?B?ZlpGeHo4UnBxTlYwMkM0OWY3ZnhocnJsTkZMTUhQTmlGblF2YlVucndyOE1X?=
 =?utf-8?B?OVRVMjRQZXBzRDlkeGI0UlZZTnFBWUNabGpRWmFyVWJLTHhMWER5dHRHeGJD?=
 =?utf-8?B?ZmMyVHRMRVp1OHhBdWpTWFo4OFFjZ3ovOTJFTXB5OUtzRG5heFFsSTRHM3ll?=
 =?utf-8?B?VHpGVWlPM1c5R3dtZDVMTTNYd1ZVdzBXZ0FpSjJrNlNpeFdUeU5BbjZJcGd5?=
 =?utf-8?B?U1djWE11QmdKNkpITzZLRFNMVDgwZUxKbno1OXQ0dEV5OUxUQlRGUmJtUmRw?=
 =?utf-8?B?bVFvT2hOMEFMQXNLelBvWUZDSE82blMvcnY2UUFtUU9INzJDQ29hVTM4cGhm?=
 =?utf-8?B?NzUyRHB1dlZoNll2WXJvOExHM0pLNjRTM3ZFTzR0eTFEUTNCUVcyL0tkcGdE?=
 =?utf-8?B?eWIwVEFiWG0vejhKRzZRL1VTbWJiQ0FYbXhaajNMQkhPaDhuZVdUV0VlLzVz?=
 =?utf-8?B?RUJnVkZZWWp0Si8ybExGcjlvRFhKckc1b2FkOTNSL1RBSmZpSFoyTWh5emR2?=
 =?utf-8?B?Tk55Q1k3SGxIZ0ZSYUlZZ1RicDVNUE94bEFXSjVsUmRoZmpOd2VBdC9YTFBl?=
 =?utf-8?B?ZWJHVldMdEptd2pBSFAvTUFQL1RZZlkyOUR0WEI2L2FTdDg0QW9PWlFoVUhO?=
 =?utf-8?B?aWljenhscWR1L1FSaithcHVoZ1A5NVROMjJsdWs1bnZVMmcrWGoycUhaY2Zl?=
 =?utf-8?B?TDJqaUYxOGlKalBRei8zOGhnSm9HQnU5YmY4dEMydS82KzRXd1BWd1RsWURX?=
 =?utf-8?B?dDJZS215ZkRNTkpwZzROdTl6QWJITWZHM0EwRU8yd0JSTnp0aFZrOFhUMFFh?=
 =?utf-8?B?RzgyY3RrajhjWkoxQ3FZNmgyZ2RTODN5Ynpwc1Rpc2krZnJDSmpPc1NMWnZx?=
 =?utf-8?B?ZFdFMGlGUjJvb0FQbTErRmFqTnFlNEhpWjduejRlNjBMR2syeUJqY1Fic05t?=
 =?utf-8?B?K2tVSG5aVGVrbGRiRVRWZlg2a1FQYkF4S201dC9iUHE3RDJnakRZYlExUzFI?=
 =?utf-8?B?OGsxMkZHbmlvbFBUVXJpS1lESUd4MWlCMUdGSkNiZ1BkUjg4VzQ3amxpS0ZK?=
 =?utf-8?B?Zjc5akJxVllzUFJtWE1EeTZHMk54SVZoczZxUlJqdVFnVnQ3bGVyYUpYOXVI?=
 =?utf-8?B?QUFjT1FKZkhzQStsUXM5RzNKbUJVWDNHcCtEdzF2WEZUaVg4QmkwUnkrVWtG?=
 =?utf-8?B?VVVSamhHK2trQndnbnZkWFJDeEN6RUVGQXF3WlJTYkk0NXlMY2hGR2s4YU45?=
 =?utf-8?B?cVFUOXZkMmJaWWlwSy9RLzlwbTMvbm5ueFBYVGhNZXB5TjQxalZ4aisyYmRl?=
 =?utf-8?B?MDU3anB5VUVZQWkvemhQNTZjbjN5aVQzdENGZVRMb1NzcEdZRlFvbm5JYk51?=
 =?utf-8?B?VDlNV1l6S0NiOUV3NkV5VTdQVnFacmlMM2tMS1h2VXZaY2JHSUxsUmRaY1FF?=
 =?utf-8?B?Rm9CTmpvZThRNjdxM3M2T0tSdTgrYnZqQ2s1NjZsNEQzWVMxSTJ5dXhUWVFC?=
 =?utf-8?B?dDRnMFVFbmNkdzlDdzFFMytSV3hqRjNXOURkYnBIN3J6NnVSQzZrMEZ6bk9R?=
 =?utf-8?B?ZDdjenYwTU9NK1NJb2RPcE5CNDNobDdmOTFVQ1QwYm90bmhBVnFuUU9yWEpS?=
 =?utf-8?B?S3pBUlF6Q2VCMEk4eVNWRGUwK01oNk5sVGVLUHN3Nk1oSDg1ZWkzaTNZaXFp?=
 =?utf-8?Q?sv8G42pnUg0bGe8w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aa9e16-4fa1-4dc1-3829-08dec6339b6b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:08.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUc6V8NXSOPvJ3MnuvITcoLqSJOD/Gishy+mctB61nZaMBr/FQv2nsfTHR8biWr9WzaV7X4wUnVLaZWRTmkgIaqkrMK+Z8l32VW+ZUpyrzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7784-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D99CB6613EA

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Enable FlexCAN controller instances (can0 and can1) and the required RCU
irqsteer interrupt controller on S32N79-RDB board.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258e..65a595d7535f 100644
--- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -43,10 +43,22 @@ memory@80000000 {
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &irqsteer_coss {
 	status = "okay";
 };
 
+&irqsteer_rcu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0


