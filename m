Return-Path: <linux-can+bounces-2233-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E929D9A42
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 16:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32581B22C2E
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2B1C1F02;
	Tue, 26 Nov 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CiI6iJxV"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73485208A0;
	Tue, 26 Nov 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634121; cv=fail; b=StjxJEXS7SW0yIHiL566QV9oWO6KVI2a6gs53EzmnW3kTYFtAvzM+h6yaj1QWBmz1XS0YgvHzeCilrL/OEdJXeTyeJB14Q/toYcLqp2ICAiTKgDh1JGViywE+F5wbhecoa0pD1yNF/J8xb3r1DMhU7cpmfMB2D3mNApA9pNmu6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634121; c=relaxed/simple;
	bh=rDh0n+9VzFj9A1DnSh/cn/aU0ifDdGyZ59l3XzVpnQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G97W8+XymcDKZWbFBp01+J66f/H9WHV0dI2KH53kAG2d+t8RL+rfz/E/UTNFpB2IrXAKAOSvWwng0heVWgbZDc3XtHic84p8+2JnLU1RnoQpOwL+SEhWX3WwPW60i3rmbc+QaLFuJj83PSQtpXJ9YwVd3+kpmIP1KySm/6J5I0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CiI6iJxV; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAcam/D8tgnetX6PlPpI0Gtldc+ikmb6/X8/HcXNNR78q0BlxGc6jqBztPLmtm1uvE7ZKl0NZFeik8u/z1o2X5v1cxaRSN0t3iSQUWJ5VvOLfN8D256eDQ8ufhyls/a5QnPHCQkx5Ji1ASWxvBOluoeyukHV2wRWqh2V8uR8KYN4rDMMMAlClzjmFTiFZQBcAHJbu7h9OmuQNPJq39S2mV8+LEwl6mALI0Z61eMtl7czYjInpSGyBrXo7FEqzMKCsi/af5HPlBZkrH+Tz0E76NVYnC6P/fxfxM6IpDGWNHJggvYfDpvkUzGnzR5k+ztkh0OtgJ0FUkX1q4UDWTVGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX8HId949agjglopdA0O4rE6P9ZK+0I7H2SJtzd1R+4=;
 b=u2STX/DRC2nzETHlEy3f+Q+lBD4zoQ8tJPDXKneRYKYnhBBs/YO16xLvhkE3rG7pJFn79fnx3GCAdPt+kBLdRIwFCMJokvzAgzQm6YOMExgQ50LJp8DxtNsRWG3/5Qi6oDwGkfN0HlABlUgwaOjnEmMApV1vbP+9QYr+uoCN04eTh7AV2M/LhGmNN8N4WOCyOVy+mbZfPfr+jSkQP5yAks8jWOaOsIM4f3skQeEj+oazVI3It+Cltswwyksoyp02a7igJ04UWsJFiwhQyNwS5/1Qk3jXg5LW2efpEuzvvJDcQohPw4Xw6xPoUOLb6l6+xbkg3c9OPzTibliJCB1L/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX8HId949agjglopdA0O4rE6P9ZK+0I7H2SJtzd1R+4=;
 b=CiI6iJxV6cjRK53OOahSCnLmph8lDjLOZhG9tIZGRbACe8PHWOU5f7DhTJIoNk52YekKSWG1HVV0tNMZ2ruC1T6ncPMelHwTaWE11HbMvoK9nAVrDD6prmEhlCcMPbAg6Wg06iEq2YZ26Zucmudgz1DePa5bTvPDTZpWiBTjZ0qbF+msqUWpt267kmkAmxLyXpULAeCWtROrLNU9LLa72kS+iYBg3QY4KvVCPteCoHllpEApnGnvmihdyVi2ap2CY1pw4tEZrw1Ji364qWWB7Utpgh6ZBablPCctkarQLWzdMVjV4eJjDSEO1e2U91/dxBKwhwcuYyBYbNcK2qqQyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8453.eurprd04.prod.outlook.com (2603:10a6:20b:410::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 15:15:14 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 15:15:14 +0000
Message-ID: <1a9281ec-3a4f-4175-8892-ee2e1ce1308a@oss.nxp.com>
Date: Tue, 26 Nov 2024 17:15:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Frank Li <Frank.Li@nxp.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-2-ciprianmarian.costea@oss.nxp.com>
 <y2fbsxg4pney2iapzcdooxyz6l3pmw6ms2ddupf637svitelbt@wthu23ld5ryq>
 <20241126-independent-crocodile-of-finesse-106009-mkl@pengutronix.de>
 <01a7de95-24e2-4c75-a818-bbc363e89844@oss.nxp.com>
 <20241126-capable-vagabond-tody-8b3717-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241126-capable-vagabond-tody-8b3717-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcf2515-94e4-4c8f-8eb3-08dd0e2d2082
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWpMa1ErMTFUYnA4djdVZ2txTTh2SHZCRDFTckxMcG5Xd2lZUCtYV2pVclFI?=
 =?utf-8?B?N2YySnJOL2RVbnJZcWtOZk5GNk9IekY1VW5tZDZjdmU2b3pLazBPSzVDQUcz?=
 =?utf-8?B?WDA1OWlqYVBzLzdMM3ZXcFB3cU4wZlIvbkhGekZTQ3hFVlRlanJpbkhNNHZz?=
 =?utf-8?B?WmVBY2lRVnBkNUFRa0RsNnVhbWlnWmxGcCtkK3FSQWdmOGtnS0JoSjJyQlgw?=
 =?utf-8?B?a21zby9IZE5RRjV6SnZVZjlkNmcxcjNYZjZsV1llMHpCTUdKY1FMRGpzcjBy?=
 =?utf-8?B?NHVGdUhJYlRzMnp3R2lWd1hQT24zVmNNUnhFQTlJRlFnOGw5V24vZXY4T0k4?=
 =?utf-8?B?NXhRZU5DUFdEWXIxdFcwaUdsaWxGVWdNa2lOUWZlci9CSVFuZ3hubE5MeENp?=
 =?utf-8?B?UlJkSW1LLzZCWTkxM1k3dGc0QWpjVFkxVHUvNUVtVXFsMk5lMWxMUmJmajd0?=
 =?utf-8?B?eUNvR2lTajhnbDFJSVprclJMaHFTNCs4ZVBZWVMwaGp4S01VK2dRRHdBN3dq?=
 =?utf-8?B?cU1GTC8zdndERzV4T05zZGZ3bGExR1NTSmhpSXNCRFlHaUVTL2dXVVo1eHR0?=
 =?utf-8?B?MkNVWjU0UXpJc3J4amdKZ0JEbkpwUHRvcmwvQm9sdTh0aDErQkN5OVVGSkhF?=
 =?utf-8?B?TUp1M2d1NUlpZkUzQTBKQW5Fa21Hc0tnS0V2b0hhdHdRbXpoZmk3QytqTEVZ?=
 =?utf-8?B?QUNTSWd6ajE4anN4VUgzb3F5Nk1kMDY3UTdLOWE2TnhzeUhCc0g2eWRyWUFx?=
 =?utf-8?B?UTVTbllxRmE3TlMzaC9rRFBrUzdGVCtlQyt2ZEMxVG8yUFJKUUlRT3h5Y1du?=
 =?utf-8?B?YjVCTmh4QjNxUmFFb1lSdjVFcVg4SGk3bmY4NVhiTmUwY01QYWFWNTQvWjNI?=
 =?utf-8?B?RXBvN3dEMVIzTDVoWU9sQWx5T25yZWZ1NTM0SXFlSFVvdVlCekdUSXQ5em9S?=
 =?utf-8?B?NHl0Z2FuR2hJRmhNc1NBYzFoYU5XdzlYV3orSU1sQ2pBSHpHYjFQYncvQU9O?=
 =?utf-8?B?N2RJay9FRXBZbUk5emEvTmNXUU0yN0pka3czMTVDL0o1QzY5dXhYNnp0dmd0?=
 =?utf-8?B?cENWaW50b1hBOS93enZZTzNRTGNDSXduVXFwV2N3VlRNYXVYVU1GZUFFN3Ba?=
 =?utf-8?B?RkNXUVd4dGVGRlNkb054RjZCc1JRR1BrTHJidi9NdGxmTVMyMzlCK1ptSVJN?=
 =?utf-8?B?Y0h0UFhxK2RMNVlwY3ZPb1ovS2VMcVJUSXFUSEwvVm9MaDcwSE9oMm8zUW5E?=
 =?utf-8?B?aTBabDRodk91Nkltd1lCZmpFcUc1VGcra2FZSC90ckx0c3Ywa1ZQaHE3THVO?=
 =?utf-8?B?Y2FyOUhSYTVlK0EvTmYwR05TOGZwaXJjWnRKOUVwMkpBRzlaMW5FeEZaaFFX?=
 =?utf-8?B?M2J2aXFzcnQ4VzZXM05OS09qWWdhOGorOVlZL0o4WDQzQ3NENmxFeE5GSU1a?=
 =?utf-8?B?OWRXM0VtMHZqVi9oa04rUm1vaW5NcHNHTWI0R3NGNGxqM2x2SVVCWnlPY3hY?=
 =?utf-8?B?WHROS2taaU41MEpJMG9iZzI3VkhUT29pdDVKVHZKK2ZTY1JPRVZ4NGhEaGdE?=
 =?utf-8?B?dm1yZVNsdlpMakhiNG9NaVhCOWxUTjBnT0tFRHJTS2N5SzRIeEJCM3Qzd2dj?=
 =?utf-8?B?ZnFkQ1ZITnNscEZ2ekg1U25QSVhUOWdmbncwK0xwS0FsZ2tsdmR2MDd0UCt2?=
 =?utf-8?B?Vkk1dE5LSUtaKzhLWWF5bFZkRTlyNFBCZithRVNsV1UyQWhHeHB5YnNsM21X?=
 =?utf-8?B?WFBUME5lZFJ3OWlzOC9EZEJFYURTVEp4ci9vTHRyUFd5Mmk5TVRrRk1BTkpP?=
 =?utf-8?B?WUtLRlJnRnJNekhEYlQ1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXBJVXd1VHZpZFFUc3BySzhqYXhpMG9QVzRRVnFCUzdMRjZBSkV6Y2c0WEJE?=
 =?utf-8?B?WS9BSC9BSTdlWE9BWlRFUkM2RXd6ZmVvZmdVa2pXUzFaUFF0TkRKeExXUDNC?=
 =?utf-8?B?V2l6cWVTbGZVelg2eTRzb3pIVmVqUmxOdEpMYnBwRHlCcmxlZm50NiszMnls?=
 =?utf-8?B?YmlucUtMZXp5L1paVlBlVmRNOVYyVnFvZExGS1dFaFp0bGc0OHJYSjl1bmI3?=
 =?utf-8?B?ZjNrSVNxZkt4MXZWQjJCWkljLzNGMlpkblpqTllXVTE3Z1BNUWpncWtpRTBE?=
 =?utf-8?B?RXVIVzcrQXZDV2NlenEwOEllZWRscy9CUjI3anRpME1NY0FkR0lHVXVWOURr?=
 =?utf-8?B?YTB3cEE2d2NzSUhqdHdKcHpXeTRuakN3L1N5bTY4ME1NWklrRnRGYUszNDBo?=
 =?utf-8?B?cGI4UFY5bG0vRm9LeWpYaElTbXVlUXpiSFY0c0U1SnhFakg0bmlldG9LOEl3?=
 =?utf-8?B?UkZHYzNkMTFtcnlJNTR5TEh5MW5rUVhlSXQ0eWR2eVV3RFFCbEtmNGVkZGlO?=
 =?utf-8?B?TkJ2VGtjcTFMdUljWHRyRkJtR2VNYzJmU1RzZUIwbGFtdS83d0oveFhFZ204?=
 =?utf-8?B?eDNZcFFpR05OMWNCbWVtdHVtTzAwalhvY2hmMmxmb1Q1WVpRQm5hLzZ5UUNp?=
 =?utf-8?B?M1RmSi9NbjFobGhYQmlwZm1SeFV0V2pMcjgwaUM3SGJMWnJtQks5Z2JMQlgx?=
 =?utf-8?B?U0xUcFhGUVNPSWNScVRHWDlmdmxRWmszNFlLZWhXakZPZnpQQWJvb0lYanc2?=
 =?utf-8?B?SGNERGI1bEgzKzVGWlpKVUhlcjZhOTZqb1F6d1ZOWVJxUi9iSDc2QVBKT1FH?=
 =?utf-8?B?WUlrSW04dXgydnlKWmVnMzd1UytaczZMQUVsY1IyRHROWnZZNk9aWGZhSlZ2?=
 =?utf-8?B?UkVZN3QxKzJLNFNNUHBZdk83U0JHRGFjSTVqa3JjMlRGZS9BM0dwaDM0b3N4?=
 =?utf-8?B?Qmd4RlBFeURlS0ljYWI5WEVDR1RSSE1ZcVJ3Ui8rK1hnS0ZQbmx5Ull4Mzl6?=
 =?utf-8?B?YlZweHVqSnY2K1RCK2R5eVhhRFhUR2kybmIrbmNkeDZhWXFUenBtbFNCWElI?=
 =?utf-8?B?ellnTkcxM2RpZkdhSmhOaHZuT3U0bWhxUmUrb05xV3ZqdEY3SGlUNmI2SUc3?=
 =?utf-8?B?Ni9KL0NVdURIWUVHNWY4LzlwL0tBd01EcUpKK1FNWkZyVUJGcUdERE1RTnNH?=
 =?utf-8?B?cnJmS2F4UmpWeHZBN2d5bHg1c3JSMjJ1Q3FLOE1OVDZDczVuRmxMamNNc0l3?=
 =?utf-8?B?Q0E3U0NURVA0TjdWY3duUTR5RllDNEF5Z0NvL2VVZ1cxNUd4WG5jUG0yTFJm?=
 =?utf-8?B?L0c5cHBYMkIxNnNYVUVCZk9yZFR0SE9kOTBiYkxFUzUvYzJsejlwQ0tOTTZo?=
 =?utf-8?B?SzZpRWNBTytDTFMzdGpSWm55dW0vcjVkdmZPZ0xyZVlnR3FKMUlIUW9yUTFh?=
 =?utf-8?B?N05NY1FkOFp0QWhqaXl4WlJ0L3VyY1FqWDhtRFdreXJrbUlQSnZ6am1TcXll?=
 =?utf-8?B?T1NURVpDOWxZaEZKNW8xdEgySDZsa2hYR245dUh1amxjZ1dGUysyeGZPVG5I?=
 =?utf-8?B?T2RQUURhMDYvMHNIeklBbmQ5RmE2TlNCNjBHQTgvZTluSGM3NHdWR2VBK0x5?=
 =?utf-8?B?dzlBOXg2QnFBZ3lsdm9aZ1llVkR1bHBWWEZoOUx6Z1VhY2ZXSC9kWjM3VDRR?=
 =?utf-8?B?ZEtYeEwvUUJ4TldGT3BXdUUrR2pLSEpmMGtzNlZQc0VwVUErZElVYzMyMGVM?=
 =?utf-8?B?bi9JaXExNWY1VHV0Q3ZDSGdOZUhSU3V5WTlRdDhLakVLNmZmekdqVkxFd0Ro?=
 =?utf-8?B?dWxHVXFGN0p4U1pBYUs3RFZRVVQ3QlBvRUh5R2JZRzBXY1dpdG01c3BzdDhJ?=
 =?utf-8?B?ZmhUbUxFSm94QTVqYVVWY056NjhkSHREWXdPQUp4V3BJWGlRS2t3dStYRDRN?=
 =?utf-8?B?emk4Vnhmd0gxVTVHQ0d4MUI4bzFMYm1BcTRmcC8xeE5wdVBCMGVUTjJMcGFq?=
 =?utf-8?B?QWIvKzdxMUtGVlFqbTEvdWJ3WFZrY3NCUVBQckpCcnVFanpmSEkwWDFDR2NX?=
 =?utf-8?B?dVNGSnhPSWpQRWR4ZnpDU2dyQUdVbXhhTS9ndkRpYkJuS2xuVWl4TXAyM0xK?=
 =?utf-8?B?NWUvTGFHNzcwZmxHa281T1NsbkN3TVlzYURZK2IxWjQ0NmRMZ0xWczhsWTdI?=
 =?utf-8?Q?4UZ9HWamQyXwo3C/jK1Vzqw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcf2515-94e4-4c8f-8eb3-08dd0e2d2082
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 15:15:14.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+I4wl17l5rqNnwp7dFdUrageKYkUqn7DZxJFTpgFIKd7qX08IKDrIcXT/0OKFzDk4JdfOKmxHN7PXBuYicXjd5JIlJxGe2r5lFHIQKbH7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8453

On 11/26/2024 5:02 PM, Marc Kleine-Budde wrote:
> On 26.11.2024 15:48:15, Ciprian Marian Costea wrote:
>> Thank you for taking time in reviewing this patchset.
>>
>> I will update description for the first irq as:
>> 'Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO'
>>
>>>>
>>>>> +            - description:
>>>>> +                Interrupt indicating that the CAN bus went to Buss Off state
>>>>
>>>> s/Interrupt indicating that//
>>>> Buss Off state status?
>>>
>>> What about: "Device went into Bus Off state"
>>>
>>> However from the excel sheet I read it as a device changes state, to Bus
>>> Off, finished Bus Off or transition from error counters from < 96 to >= 96.
>>>
>>> So "Device state change" would be a more complete description?
>>>
>>
>> I agree "Device state change" would be a more suitable description. I will
>> update accordingly in V3.
> 
> Thanks.
> 
>>>>> +            - description:
>>>>> +                Interrupt indicating that errors were detected on the CAN bus
>>>>
>>>> Error detection?
>>>>
>>>>> +            - description:
>>>>> +                Message Buffer interrupt for mailboxes 8-127 (ored)
>>>
>>> nitpick: all these different events for the other interrupts are ored,
>>> so IMHO you can omit the "(ored)".
>>>
>>
>> True. I will update.
> 
> Thanks
> 
>>>>> +        interrupt-names:
>>>>> +          items:
>>>>> +            - const: mb_0-7
> 
> I was wondering if it makes sense to have an interrupt name not
> mentioning the exact mailbox numbers, so that the same interrupt name
> can be used for a different IP core, too. On the coldfire SoC the 1st
> IRQ handles mailboxes 0...15.
> 

I am ok with proposing a more generic name for mailboxes in order to 
increase reusability among FlexCAN enabled SoCs.
Further specific mailbox numbers could be mentioned in the actual 
S32G2/S32G3 dtsi flexcan node.

One proposal could be:
- mb-1: First Range of Mailboxes
- mb-2: Second Range of Mailboxes

Let me know if you agree to update as proposed in V3.

Best Regards,
Ciprian

>>>> Choose one: either underscores or hyphens. Keep it consistent in your
>>>> bindings.
>>>
>>>>> +            - const: state
>>>>> +            - const: berr
>>>
>>> The order of IRQ names is not consistent with the description.
> 
> Sorry, I misread the interrupt names and was under the misconception
> that the interrupt names have a different order than the interrupt
> descriptions.
> 
>> Good point. Indeed the order which is in the S32G3 interrupt map excel is
>> not consistent with the bindings.
>>
>> The reason is that in the flexcan driver, reusing the
>> 'FLEXCAN_QUIRK_NR_IRQ_3' quirk forces the probing of irqs to be done in the
>> following order:
>> mailbox (irq) -> state (irq_boff) -> berr (irq_err)
>>
>> Hence in order to maintain ABI compatibility I am proposing the following
>> order for irqs in case of S32G2/S32G3 SoCs:
>> mb-0-7 -> state -> berr -> mb-8-127
> 
> That makes totally sense!
> 
>>
>>>>> +            - const: mb_8-127
> 
> same here
> 
>>>> Choose one: either underscores or hyphens. Keep it consistent in your
>>>> bindings.
>>>>
>>>>> +      required:
>>>>> +        - compatible
>>>>> +        - reg
>>>>> +        - interrupts
>>>>> +        - interrupt-names
>>>>
>>>> What happened to "else:"? Why all other devices now have up to 4 interrupts?
>>>
>>> Do you already have a dtsi snippet for the flexcan nodes? Please make
>>> sure that the interrupts are correctly mapped.
>>
>> Yes, I am testing using the following dtsi snippet:
>>
>> can0: can@401b4000 {
>>      compatible = "nxp,s32g3-flexcan",
>>                   "nxp,s32g2-flexcan";
>>      reg = <0x401b4000 0xa000>;
>>      interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
>>                   <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>>                   <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
>>                   <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>>      interrupt-names = "mb-0-7", "state", "berr", "mb-8-127";
>>      clocks = <&clks 9>, <&clks 11>;
>>      clock-names = "ipg", "per";
>> };
> 
> looks good to me!
> 
> regards,
> Marc
> 


