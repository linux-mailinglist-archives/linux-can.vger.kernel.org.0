Return-Path: <linux-can+bounces-7383-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH44LS9R52mL6gEAu9opvQ
	(envelope-from <linux-can+bounces-7383-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:27:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC14397F4
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16CC6305A26F
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361A3B8BBF;
	Tue, 21 Apr 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bFolzgs/"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABA3AF653;
	Tue, 21 Apr 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767179; cv=fail; b=k+V+yQPQR3HSLZ2N+Oj1HcVBRqcah0RlinKZ9f6ZmbdDvaETTX6rzwXxa5+EgCsfllWytPLSqxATvKX/OFN926FKQJskiA0kbVL75uZMn0rB3YrqOP3Tf+Zdj8tMoG0YHEq2ZJ4i2SdwHJnPRvk7ki5qNeq1iI4LYkDlyP1Jphc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767179; c=relaxed/simple;
	bh=8EOsHs7J6ANm39x00dNUt4uy33ChTfGHoogRmHAEvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZ6GhK5JpdSzkMbUXDssTgviGA3l0UjKQFG07+IeBvl6ggy6pfRHSUgm97EVfja+hCqw3wgN2T4GX36F40BYvlQUW1zjrYXnskZgqrz/pcqn0JsURWAIvkFwzDR66rRGNT7PJ/WuXUo+UUCxF9Yb6i8B1Ga6iE6jfOFIlkkQKUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bFolzgs/; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO0aK4I2DQlX4PQBqu0EXb2OVFTLOeEAAHgk8TGHviMpBZGTpag6cKpVPaoCDfyGwwD/6d+GFNdIqraG7aKXc+ihSbTgxIe2bvAnoJEpbjGgyIcgQFkabRxU3SEduRdCF6jmqv144bXieeMDUBRLY+EJKSLaLXDypwEXSXcNW7d5MysdHJHpbCQQ3j56+7yIbOyXuJax9rBtQ2IZAsEoJWyC48uEL5RC1xs+4N0+zc7l0VU3n1nqQ9Nxdgy+GcgiQgUk4mgyikFGFv7tVtxaEtlthtOlBUtO6VaQE22Dh0qrmjtO2XboI4y+GFMXyXcOwRE/iemkLs8pfZfazUcH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY/iIRo27uKIqzkg/Rz5IhDiJmPYK8ia9+8E4UiWGlk=;
 b=NLr5d8igNl8JBrmCz6PF4mEwxAW48G0YbuG73cyuqj4rPpeWECAULOqkjN09bz0zu54IjWWAGCaRgyY/SVZdL3cgoFriMJ/59P+gjKB4BizwrynBbdW0TwKm9ijGvdWvhhJT5auE7t1HgwOccZMONt7AiF1Yc26fE6EjicXk0omY/RGky57cToYTERspqAdrVk7zabbyMktXIsCw831IHHWXnQkvgF4aenttTS8Jf6eXOSj27MEUCNLFFgIm7Kv53oPzB5XK6ZOXaoJ+XvJWqqOkEw65+CPIw5jhOW1ATH/SIaWSF9s8XH3LaUQKSVmDCB/so0837l2BFGme4SxbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY/iIRo27uKIqzkg/Rz5IhDiJmPYK8ia9+8E4UiWGlk=;
 b=bFolzgs/rjgoHgnK0G7+3txUaPLrwPvZqZevVTAV+2MhnelTaxp8HKv7QEnouekLGdLUBClfL1OY3VlPN2+VrWfY76FkHjw6tMocSW+LE0xyia1rNA24KXDuJn40RGDdhIsIvDFL+DqDvGumXDkY7Oecvd00X+wNmkbH1oYDqdBPC8k/4qVOTkEyBCPSdy67W1OqlQKLI12q8RZkwH7WXKbsba3CzX+3F4z9FNuJJVrymOjfwaFFSAm4uhtWv4Zg4Zj1vn7R4ApaAlJVIaMv0tr34rk67XmOCrAJxWzsEOmfcCZQ9pTCDfBlsdbZTweTGG//8nLgA/V3IYCiRBcemQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:26:09 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 10:26:09 +0000
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
Subject: [PATCH RESEND v4 2/8] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Tue, 21 Apr 2026 12:25:57 +0200
Message-ID: <20260421102603.4122332-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b7e7f2c2-1cf4-48d2-73c0-08de9f90674d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 /iYs5ftT5O8+lW7XWkcO1cox6Cm/TbgRmoRQD7nNwQRuj3wU1aXPEePJ7DK8z1AnmdpYnHvmVk0rHyLehqV3A9UM5IFb3RibJh2QyvnppTEX4GbsraPiNzauAfDb0lI7bw4Ba64b4aJNvmK02Az2jXtm/khrQDA0wleL1GEZGQjvDc5XM39YPo3wL9pFjZsbFQUktVvZYFNIefl2eAAFLu4/0e229ey2XIEjQOR+fQvdJLLqJCJUHLavxaIKzWeQxssEVXXMp4pUtNXCZWUJ2qlujt5mij9remcEFReBLY6JpSA1ubN0k6E1KRvirvW6u84cLLJs7j6v/TO9ZAjMCIIPFfst5zKl2FR2jNeef3r815s1+5V/x6CblxjC/SNB75ddKf8Li6zEj+p+la49HTDvWiQAuOXA/jMYu1bA7g1/EeFWe/XkzV0xbs7+PPb3cTANv5X8X+9KNhg/PE3llI3feZDysPlsVvt2QzY5Wl6QselUFEcQhzHlPEIA0qwYOCFMl350XvY2DKZ0P1KkezwXZO7WktjC4V/eekcwwjSD8m+f54+KudblWx/6Zm3BNiQaoRx6e5SwmQiKHotst0LdMdZlT/76qeKmgejw4URzU88mdJ2XhHS58smN7S0QZ+W/Stj9qJzBlc2/l+KjIGiqesNoNtN7be9kFosNxq1RoknUU8jU7nzYwJ7+HCr4+QZq5HBp7piWK7j9Y0UhNSbcPMgqLnmYoXLYp7lqmzg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SXErdWNPVjdFTk5lQ3hvUVBxOGtERmZ4MFBPMllVZmNiaGZhQnIxd2hBVEt4?=
 =?utf-8?B?WnBOZ0RqemxZenhVYlY3bWhDQ1N1RXNMWUEzWDhTZCtaR3JVc1dGWjRFZjls?=
 =?utf-8?B?WlR5N1piVkgxUmpEa2RzNDMwaGhoU0hXeDFzYlBGc2hXb1BjcGI4SFhjbDRL?=
 =?utf-8?B?cGV1R1NadEtqQVpGM0JYUE02NHEzOTZLa3RxNTZERlZjU0VVM2JZcVB4ZU4y?=
 =?utf-8?B?bnhSTCttdEN3aHh3aFJ3dXgzN3ZSSjczUVZzVUFFMUFRajRiaWloZWNrUWdL?=
 =?utf-8?B?bUNkRVB2a0xpem9ibW9oNkFuQmFjdHVRb3JXdUFYYnhpdU0xZ2wwOEs2czJ4?=
 =?utf-8?B?N1FZSFAwa2FBQmhPUVBablZIaUdpakRRbjRnS25JcmJBQksrZ2l2Q3FNcnFG?=
 =?utf-8?B?UWJvNW1aRVVkS2tSenlMRjE2TzI1VS9SZ1VHOUF3bm5TY2YzMmNxTHFoYlFL?=
 =?utf-8?B?S0NZdW5vL0VocjVvV2VmcS9rcjJmZzZSN1QvRUNKcFZqNDhJZGRuNFdhTldx?=
 =?utf-8?B?bVJHVFJ4MDJYRTF0YVZ1TllWdFZ2dmkrVTA5UHF4RUdyR3pFTVYrUkFyMWp6?=
 =?utf-8?B?ODJDY0ZnSDdTWmUxUHJGU1NiWXFBTityUEM0cW1OWFptRTE0V2x4VEVrNVVZ?=
 =?utf-8?B?L25ITlkrbWE2ZlAwTFduenV1ZDNHZEJJanhrcEx1eXk4ZjEzUlY3cklwbFJ0?=
 =?utf-8?B?aEQwanJGME5aZFg4eEZsZTBRL3RWOGFSd1p6bzRyYktON2tuVDRxQVVXN3Ju?=
 =?utf-8?B?cEhzcjJWU3o5YWRlYitNU2NiRWxUM21wck5qZHltcWlzaVhmeng2NEU5U2xQ?=
 =?utf-8?B?c1ZkL3RmVURMa3l2QlNySG42b2YvSlZzd0hJMXJBL0pza0NsaFQ1ckhxMTR3?=
 =?utf-8?B?U255bVYyWld0VmFsa0FtZVpjMGlCc3oxczhsRnNyY1VrWjFMTWFnY3dYZWU2?=
 =?utf-8?B?R1hwWEZVVkduRGdEYTNWUzBvK25qTUFVOHlJeVFYcXZsQnlPMStoSVlCYTh2?=
 =?utf-8?B?NTJnZUlTS1oyaE1NcW1SYzV3aUJ1MHRaQk9YdElLeExFTlk5NkNYRGlJbUNV?=
 =?utf-8?B?dkJRQXM4bWFNTEtpN0srS3RqNkR5NXQwdWlqZ3lVd1RIcDl4OVBBOHczeGlq?=
 =?utf-8?B?NkgrSEs3TGhiNVJmRUxRYXY3eFlHbndSdWZtNlJyeHZwemxKaEdGTmY2YWdj?=
 =?utf-8?B?UkljNEVrSEZEUUZEYzJPUU94ZnZiWEtvVnBBQzhkK1NaUXE5OUtyWEdsN29L?=
 =?utf-8?B?eldaYmpML0NkTFBTTkk0SlJhalU3dytMNTY1VUlYZ2ZYM2d1Q1hXMFR2Y01l?=
 =?utf-8?B?cng1bU9aT3Q1RCs5bC9LV3IwWGhXZklqdnM5cjhnRGZ6eFU5ZmFORk51d1Q3?=
 =?utf-8?B?S1pIcnVaTU0yTTJkNGdURXcrT0tKcG94MDlVNUNBSjluN3JQZnkxMytIdXA2?=
 =?utf-8?B?dkFPR3ZEWkFETG9XaDdqUFZFdk1xTFNMVXlNbEV2NVNGMzBIelVZNFlzSHZC?=
 =?utf-8?B?dWlTcTd4bnpUbHdGWWQ5Q3lmbEtnSXR4Z2J2SDRaRVJ0TWlWdVVvUTJnd0NN?=
 =?utf-8?B?VzA2R1d3cnZGemJMZllFSERncG40WXZjTXllcFdlYng4Q1Fja3ltR1hnQTlK?=
 =?utf-8?B?bTYxTTdkMmc5TTR2ZU8rS2ZTZGw4amwyZTN1bURrbUYrdk5QMERlZHlWQzJK?=
 =?utf-8?B?QXU1U3k5TGdQU1M0ZU1FWVBYR2IxUVFVdmNCWm5HY3hlemYrRnhQOTFscEpR?=
 =?utf-8?B?Umk1OTRNTXhtUU54RC91OVFYTE1WR3l1TkxZa1M1Zy9LRm1qUkNXQjNySDhp?=
 =?utf-8?B?b3kzN3VyTDlqOTdjVGpYZDcrYTU1TlV6cmwxZ2l0Nk1DdGx4c3lPdS9HRUZu?=
 =?utf-8?B?ZEdrNTBTUTJ1bW9ic2FiblB3NVcvSk5aNVhsMUFGMFhwZEE1eWdBMTVCQTVv?=
 =?utf-8?B?OWlpMWRYTURyUndjOXZFaGJjZmo5ZHdyWFMrT3piL1NyM2Y4bERDTDJ2WWsz?=
 =?utf-8?B?dEFyS2k5SGxJeDN6Z0FOcG8rR0JOMXJpRWhKOHZVbGVoMUplTHoxS3VNSjVv?=
 =?utf-8?B?bFpGSVlxaW83Y09PaUlUbU95Q1lwdkUyMnRVK3Y2a0lnMUhmT1IvSSs3ckxr?=
 =?utf-8?B?WG0zeWdMMTZsVEsxSTMycmpCMWNGaE9URTdxTm9QMm9PS3JPY05FZ0lnaVJz?=
 =?utf-8?B?ZlY5Vnp6S09sSlo3aG1uQ1NkME9oSk4vUk5nYnJDNVhMUnczN2tURUVtRGxp?=
 =?utf-8?B?NU5pa0JVS2hGR2kzaEErT3JkNkkyZG1YY2xXRVg3a3piM01TR0JwWlV3dGRH?=
 =?utf-8?B?RHB5Z2Y5NnRlVWRLTGk1MVZxM1laajV3NlhXZUNQWUMvYXFQUlNZUVg5WGVL?=
 =?utf-8?Q?0l3IW43UQeecX1CM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e7f2c2-1cf4-48d2-73c0-08de9f90674d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:26:09.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEZPHoKNFp/H1LzVJDBIOc71T799uJq90B6NkfaHwT400tLOPWmkEPsQXl4Jy8k+YENvQyZs2gnQFxwRmMDpVyss3DfhnKS+wT27JGbAu1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7383-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69CC14397F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f73ff442d530..7dde2e623def 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	u32 quirks = priv->devtype_data.quirks;
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		disable_irq(priv->irq_boff);
+		disable_irq(priv->irq_err);
+	}
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		disable_irq(priv->irq_secondary_mb);
+
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
 	reg_imask = priv->rx_mask | priv->tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		enable_irq(priv->irq_secondary_mb);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		enable_irq(priv->irq_boff);
+		enable_irq(priv->irq_err);
+	}
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
-- 
2.43.0


