Return-Path: <linux-can+bounces-2609-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04583A0B65D
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE5B7A26AB
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A822A4C2;
	Mon, 13 Jan 2025 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vJDBcYRy"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96B22CF30;
	Mon, 13 Jan 2025 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770040; cv=fail; b=BE3a430tFPjCM2f90TgFP8/CmeglECawwWt7W/fdZjJn8BK6Ophvyll1MwrwVWxQIuty/gnPOnnHHaOcyGfH4AhJxTyyzDqClRt+TqULYvlT7vGDrx539NO8KzMvt2Wmj2j+tbYBYhqwTNif3qZvc7y6zZcFG0Ahxn+hUjrG+IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770040; c=relaxed/simple;
	bh=z4OdTSCQ+86qVjVqzxGeoE2ZgC5pvMjXPFPwFo8/PDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCiG+t+z+0komGz82mnFOak+MMCAloPR8CL4CsHkqHdujX9nkY4VDnnQ/W2bq9gu0NVRZn8//lSQg05xgNMvPw88pIP/t56aZopnL9VH/rwDhnR3SeKEs6YYe45mjY7MXZZJzwdUDpLs7+Ik2HNOLmajWGapWs1I5gpqlOj2mq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vJDBcYRy; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhfKc2IMxxLONUCWCYgbf3DCdTm7pI78nymN13007H0MolbxkBddboSjk/yM85JwT+/Ejoa24x3DOQZalUHxefVHMRlBn0F4QkHb2vxYF9xHwjuAVdle9vTyLnaKsUZrmnY1A+b+etar6IjC9nai2oiVVj5WdsGaIc43DX+3uxujRAjARYYaTeF8vBYiFYi8zikIF7sQHyMRAj0rJEQVUugXgHdUGvG830xSsm856gipvXlneogiJSmHE8efYHhNHK/CHA7XR805fgTk60zMl+o1ph3TYEvjrov0YmFx2xCVCOBUw6btGnkvIk+kS1n5XQfiiwU3c1iYqTINxqDXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4/SyxyURhBxCNCTRbSr5XgZMgwMBaBrjZu4kumk2Nk=;
 b=tvISqBbPYTZ63pKxq4MjzUAq49xoI/yhbDr88iOe4roZX2DqPUdnorn2HcppyOMJWaXIqAyosFidfCOLQV/qerBbcRbrLo1ApCvo/k2q8W4ZIwxMvTd33zmdxu89qMTzI7DXs+bVlfRuGOv4VOLJ9aYPFmB3SN1EXZk+8ZAUNiWHXbzQbJLFfLEqJYnApeYnv27v2Im8GdxvHv/5JtqBQd488nVhCGUia8wkP2VM+1R1eq+1WkPTvIvJIt5jHFot1D+m5dI5sZwN72JlqxPDjNpgbvgFI1ZHo5/tMKagyB48cm58wmZsxjp9I4sVneqmxYGf/TtPIZ3ROnTADZj0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4/SyxyURhBxCNCTRbSr5XgZMgwMBaBrjZu4kumk2Nk=;
 b=vJDBcYRyh4rEvx8f7mB2iYnsHVTECbvtL0SVgSnttoWMRb/3Q8VWGFjqhVXv7Q43uekdcTEFWN40+0moVp7g7DC1ZFTMMyntmtbAKsovBMWgC6sPj0fg1oTxwmp8RbYavCP4AyLvYIRNlkV97n8U6yCXNhLfmECdg/Brm7l43x9QEauNa3TjFLmhRtR6EPAAcbx/Z4V4eGetQsIFdb63+z9UVBcvAo7cv21aLY2bgusdPkVyyh40/xC3Bb/qNUpBAmrT2uoRoPNjMJpo04VsetHD52A4VF4kE5C8g7q3/LcHSa3gQNQO3PSqf1J+/JXj+J2kQdB375VBHkjxwQGpYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:07:10 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:07:10 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 1/3 RESEND] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Mon, 13 Jan 2025 14:07:02 +0200
Message-ID: <20250113120704.522307-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
References: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: a36c03c8-3633-401a-64b4-08dd33caced6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0dXckVuUVJLV0R0MEpXUjI3clJETVkzRkZJbnRhbE5aa1VWSHV0ZUF5NFRW?=
 =?utf-8?B?dnNTQWw4OURZcW1Wcm9jelg3N1lvZXVqckFqT2NZTTdxOGQ2bFJXNGRZUjUx?=
 =?utf-8?B?WHBpc1BxcFkrSHJ3N25iVlEvRllWclh2bXE2aEN4WEd1Ry85NHJDc1JXV2c0?=
 =?utf-8?B?ZGUzR0JQZVlLcWZhRWtTZEpaSmFqdktSakVzUUxIR0NTVU1sZWJLVkswOTVs?=
 =?utf-8?B?ODhvcGdDZlZya2tZZU5LMG1QdEVIS0VpM0hWTnVPeGRMcTRQRE5yQjRKRXMr?=
 =?utf-8?B?d0padzVqWG5OdXczUm1Fejg4bWw1NDZhdmMvWXYzd0pYbHl1eTlJeXA2aHcz?=
 =?utf-8?B?STdoR3dZTXZXcWhPT0YzM0M4Z1c2R0RGYzQwVzdHc3JweHczQkZ2ZVowb2JO?=
 =?utf-8?B?bkNWNnRhT29nR3NMOE9jTmVZRm15cDlTdzBGSWtnVFlzUitQdTQ2b21LVGRH?=
 =?utf-8?B?elZrWUE5UkY4d1pNdEdGc1hiSmJIM0txTmpsNW53YjhWWVNIb1U3bVE0QlFo?=
 =?utf-8?B?MXZFQWVsTnhQcXlSM3JuL0srdGt6ak9LTTZEVVZFQUljcXUyR0NZanNnZ3I0?=
 =?utf-8?B?WTcrZ283REt0V3Vab2JJNklQWkFHZHQrVTJldDhIRG1yb2VQOTBsQVp1Mldo?=
 =?utf-8?B?aTJqQlpqQUJUbGhkaTVZTFc4ZU4xZUdpVyt6QXlEcVRLbEQ3SmxhRVoxMDVE?=
 =?utf-8?B?K0NXMThzRnVJUGNUVWNWNzNmSDJ2R2lxWkdsVGI2QlNFVTN6SG1lTStHbGE2?=
 =?utf-8?B?aEFQRHFzT0VVdFpXOUNyR3F5S3Zqd2xXWHo0R2Y3Z3c0YWxrb21qU05OYmNY?=
 =?utf-8?B?ZU9tUFJaYytMdHdSc05scDIzUzVjZnRxZTRlZTByekc1MVV4OEwrejdGVTd6?=
 =?utf-8?B?eW5Md050TzRKN2dIUWs3WU9uU1BSVzlNR0tpMHBod0hhVnZnSGdlVFBiWU10?=
 =?utf-8?B?emdjaWVxa2JDY3gvWTVaVHYwWEM0UzBEQTRES3QxOTZrQ00wbzI2RG1YTFVy?=
 =?utf-8?B?cXRzQ3ZOUTZLRmVYUXJCNmY4Mk81TjJZUXFIdm1mRlluWXVzdXhkbGxKSXMv?=
 =?utf-8?B?MWU5NmVGL0hETVpnTFBoc25MVzR6OSs1VEtoMjNISTVZQThyYldSVHJjTmxK?=
 =?utf-8?B?RVMrNXB1WE9LdTV0NmFlaHo3SitVMlhNMXc0d2RjNkhtWjhBdVFUSVJDNm5m?=
 =?utf-8?B?V3pjcmRqMXJpaklVUnhUNmxWVzAzbENBdlZRMWFYb1BPVW9yelAvYXc3TWNi?=
 =?utf-8?B?bTZCdE13TG9nSVBkNzNrVmlJUTM0alFtZFcvZllGeDR1c0Y2ODh1enJxWHk2?=
 =?utf-8?B?ajhNVGF3TDlYb24xTjE2ZVhoVjhHdlRCR1hNK3FpTjJwbjRYU2RtTytLL0tW?=
 =?utf-8?B?dFk0aDRwTkJGdkxSMUYyeFhtWEI0dXFjZmRZV0VKMXVRQ1UySGNiS3dKblNC?=
 =?utf-8?B?dXZ1YXYrTUZLOVc4Zkdwd1VodE1rQjRKNE9lQWltN29KS2Jid25QRDNkZmp5?=
 =?utf-8?B?OGhIZ1ZpYlphQmhZQW9QcW9DT1dmV0krMEoyU2UzeEVkMlpBV3g2d25UMjhw?=
 =?utf-8?B?WFJjcjV4eitmY0Jkbm1BK0JkTjFJaXFFWlNoN3RDVEFVbE9aaEEvWkJZQVdv?=
 =?utf-8?B?WnpQc0dpdjlBM0c5dzhGMUVIb3ZSWnRmUHc1RHdUTDh6WitqakIwdGx3RTgw?=
 =?utf-8?B?MUVXY01aL1FYMm4wSFR3aFJpbktWeUhMYlI0eis3QkkrQkNpL0dqTEFOQUFK?=
 =?utf-8?B?TU8rZjN4c1F6SDJIdWs5U2I5ZEtNSzdZaGlacndoR0s2dEhFam1kN0ZLem9l?=
 =?utf-8?B?WUF0c1VvZWNMaXcwRzR4cEQwaG5VYzk0Ykh4MGV2ZUo3OEYyRXFFNUlBVHR5?=
 =?utf-8?Q?/SoFO/xQbO5/h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkhvMVlwNDk1SE9kRERQdkRhMDcvRUFYamZseFh4MkVCSitmVGxwYjdla2tG?=
 =?utf-8?B?a0VWRVcvT0tEOUkxKzBWNmVUR29lcUUzTUVYS3lLMUNFdncrdlY0RGttSGZs?=
 =?utf-8?B?WENrQ3dROVp0c240QjZENnNaSVBNViszeFQ5TmNqU1c0WUl5NE9mdlZBVk9j?=
 =?utf-8?B?ckt3Y1lyVHUrRkFHL1c0dnZvQm1pSFhTdlBoQW5wQi9qN3RIYk5pQzNZZDZH?=
 =?utf-8?B?NkozMFZPUm9TSUVCbnlpYUtBUmczQlJoTmt4WWVEZ0JHY3R3bVZOUlhtQ2NN?=
 =?utf-8?B?dldkWi9JZDlVVEV1YUd0dE5vdlBZN0N5a0hleEZlS1JidXB6TTJRa2tuUTJD?=
 =?utf-8?B?MnZhWkpkQ3AvbThhSFluOW10K2hSdG1VZnJBck9RSGVxVzNGOUxJTEE1YWdl?=
 =?utf-8?B?Q1IveVN2ZjlBTlhBd295eUFjZFFkN0xVL2dXRTRYRythWW9pM3Fjc204LzNo?=
 =?utf-8?B?Zi9ic2NmSWxiUE1FNG41L3F3TlpqM0E4RXBPNjFWakF6bXBmY3NnMVBYdDVS?=
 =?utf-8?B?WlUrRGkyOVlvQjV4cDF0bFF3Q0FkSUlrdHkyMk53MkFGdmFuZGRYT1NmSlVO?=
 =?utf-8?B?SjdKbFZWOHkwdUhiRUowNFdSZldPNWQ4K3UwT3pIUG1FRnJjYU1SL01QNml3?=
 =?utf-8?B?U2xkYUdoU2Q4ZXAzRXFjSWR3bU9ZT0xubXdjYmJON0RJeHpNNW5OT0xId0kz?=
 =?utf-8?B?MWh3WE1XYlRBTGtpQjErNXlKS2tlVVRCM0VOQitFYXhqem03WTBlZGJLWHY2?=
 =?utf-8?B?aVR2RE1GcFRRU2Y5N0ZVYmpYRjVxV1lsSWhWMWlXTUNZdkJ6TGRXeVgrMWlt?=
 =?utf-8?B?RjhISWp0TmtSeDlxSUxkL0YwSjI3Z0ZZbTlTNFBTeEhYQW1xREJ0eWd3Q05x?=
 =?utf-8?B?N3dBT2NvM0d5WWZTR3VGa3Q4V1hRNVhCRmYyN1lqR2tvSHF3d213eFIzc3BF?=
 =?utf-8?B?ck9aaGxCRDFNZlUxTXZ4TnhGUlRSM3llOVk0UjNPNzVyNUlia1FPYVNNZmJu?=
 =?utf-8?B?LzBKQWVWSm84ZkdPOGMxZ2hqUEdQNlNHWUI2U0I4Y0cyVytVMGFIUTdzVWtJ?=
 =?utf-8?B?RG5ObW9oUHFsb0dEd3lSakxUdStycWZBT1U0eXptV1F1bnIzckRIejE4Z2Vr?=
 =?utf-8?B?b1J6M3VTdmdhRHBvYW4zVnhOODg1cWFHWXltbG5PWkhYeWd5Zmw4cVdRS1RN?=
 =?utf-8?B?WVEzS0FkSFFVWlJEeFlYZjFwZ1JORnllcStsZmlHbk9tWE5NcGFpa21qYzJv?=
 =?utf-8?B?NkExTS90aFp3SmFXN090R3RLYlZEdkhJeU5mOUxrcUg1aXpCUUxiaDF0azV2?=
 =?utf-8?B?cHgwVEtOeEJ4TWRUQzk5Q2tNblJJZDR1T0p1WGZKRS9HZjNkSG9GYlJ2WDFo?=
 =?utf-8?B?ZHAxK1B6eHJUVVVzUGFOeXh1RVpXV2hMdE5wTytSejJBWmpiUHZwZjBJeURa?=
 =?utf-8?B?OCtMa1R3VEE3eVQ5Zi93R29kWFpWNWRTUitnclp2Q29JS3JUUmtFQVdIWmcy?=
 =?utf-8?B?ZC85UldPMDhweERmQklmWnU0M21qMWw5RXhieTlPbEJkdWFsQW1QU0RJWitT?=
 =?utf-8?B?N2VvWnlQazlKWVhic09uQ1hlbGt6MkVFdzJZbEJaaDd5YlJXL2k4WThCMDN4?=
 =?utf-8?B?TXQ1K1YzTXh6VEh0d2xGWGwrbXgxSXRnTnN4ZTlST0ZKajYxSXExemd1K1l5?=
 =?utf-8?B?NkRFWDhwczFleUI2U3JLTXp4akVmN0lQSHBOK0RlSXFFUGJaMTFuaXZnRjdF?=
 =?utf-8?B?cy9vNlhhTGtscWpwdENQOHhHMUt5NWZqT2xJNGpHbCtuZXp3clRuRVQzUXFu?=
 =?utf-8?B?RjRMVi9QTjhEOTUybEptUXBPUlVoaVNSdzVVQ0JURWtvcmlkSHBXY2ZjZTRv?=
 =?utf-8?B?ZHFZbnYzbEQzaWhFYUtJVEEzUTFZUktMUzRxc0htbW0wbzFWbHV2SkVUT2pR?=
 =?utf-8?B?dWFNelhtcGlDeFlsK0x0Ymk1Vi8rZjlGVjNGUjhpZDFWd0swL3ZDREd6ZnJC?=
 =?utf-8?B?V2xhQ1JacEMxVlNaZVBNUFNvOHJ6WTZCNWZlV1VPN0c4Qzl5NUdYYTNEdHVT?=
 =?utf-8?B?TzArMjg5MGZyUTE4YmVqRStneGV6WG1DV2dtbFgrd0hHQ0tjYjIxN2tsR2x1?=
 =?utf-8?B?b2k2NkhYTUhTVGxZaEVhdkxsOWRUd0Q4OFZaOUlZTUlCZGdGaGpBbE9lTW1j?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36c03c8-3633-401a-64b4-08dd33caced6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:07:10.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Zu739WVAjqPM2VzywLukwMfFk7GpCKkC/a9w+FtxHte7cX3Tp9f4751LQvpih5OnrvtfN6xNWGpwow6UVCQXiChZbQNTAjjSsyLTNU7lPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add S32G2/S32G3 SoCs compatible strings.

A particularity for these SoCs is the presence of separate interrupts for
state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
same restriction for other SoCs.

Also, as part of this commit, move the 'allOf' after the required
properties to make the documentation easier to read.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed2..73252fe56fe6 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -10,9 +10,6 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -28,6 +25,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - nxp,s32g2-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -43,12 +41,21 @@ properties:
           - enum:
               - fsl,ls1028ar1-flexcan
           - const: fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - nxp,s32g3-flexcan
+          - const: nxp,s32g2-flexcan
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 4
 
   clocks:
     maxItems: 2
@@ -136,6 +143,35 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO
+            - description: Device state change
+            - description: Bus Error detection
+            - description: Message Buffer interrupt for mailboxes 8-127
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: state
+            - const: berr
+            - const: mb-1
+      required:
+        - interrupt-names
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names: false
+
 additionalProperties: false
 
 examples:
-- 
2.45.2


