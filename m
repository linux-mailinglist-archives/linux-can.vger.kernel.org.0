Return-Path: <linux-can+bounces-2320-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F59E34A2
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003BC28489C
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 07:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFD1F427E;
	Wed,  4 Dec 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tcZgQGKK"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25A1E0496;
	Wed,  4 Dec 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298570; cv=fail; b=vEI6aqj3sBpsSVZsArKBHJCIulMZ1kFH4LM1xmWa/VJ6qxx4VTgFejMTCw2TRYKt/fOC4m1nxOeo9Z1Y98qllmdb47LAKFIwRSGizROSXRLV5d/9/zJeO9eePqIkj2wzjaCdOka8ioTsDwjioKjqeiq+eTpbtDI2YdYxeLUY/7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298570; c=relaxed/simple;
	bh=z4OdTSCQ+86qVjVqzxGeoE2ZgC5pvMjXPFPwFo8/PDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZtfyznmlrQeXmXoitqf1Yw3v9KcswWPkwvG/8lkjT/O7qAuc/bU1cPY7IG2Z6//+aHhk5axO5Pb7BGwqoxNLERbKL4YAM19QRBjHkMex4tTHJJbYXIYoaCS6SptpcY4VCHtB+DS9xLG/ZiQIglTf2ThXHUDmCqTfqj5gff8ghU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tcZgQGKK; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSt5oXd1oBV4QYt95mNPtNPN5LCjjimriCsRjUU47QSaz+QJE+z8x1bOXliQronvCrG1gJXVF2ahaOxHkI2Uyfqp5gzVQdL9YKaxljbBYlsEcdZbCBzmaDCBhwqCUX9u5zA0YTbQJmiCJDpYhWE2nAVr5/iwjaPtqxroelwst48NdHG49v32y0ja+t3bB1WcPxLZUKIJCtlvuj5mesrM3f3uJK0m3NFDeudKhg+COaeXTNPa6Xxg/CC+e4qar47zfEImB49ONDudxEc98c4tUBdWPIBaf6YK8cAsH6s1y+rdTb0nGe8wzcnyY0V+lMudJ9fxzuHFcVD0pGCSx+aISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4/SyxyURhBxCNCTRbSr5XgZMgwMBaBrjZu4kumk2Nk=;
 b=vCizRGPiWLor7ghxzetWmA/OBilZLsdSgKgF/LHDFBXIkq/RHYHB9mBrwvBI5NZ5DKg8YlYUnwfvLWJT1UZKWxOGls1gyAdgNPGprmv18DbDJQIhMqzgFQS9faSGv8Cp0fAUdd5NskTdfQtdb7l7lNSJIV7ukMDgklls+99wLsAH85yObSC+OWuE9leXPS2H2xpfbUuI0NxrAGhNi3i27xxqLMx1qPJYM5+T4l0Qv8DAGg1IzaV9f1W1/tzRn3it29Kqjwx8wKVRnL4EW7DgjD7VIcLhw61e7f2G197+VHIOmvYcfc3hFj/3DDcyeiQ8gdf2rRT3E1yaaQzbLxo9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4/SyxyURhBxCNCTRbSr5XgZMgwMBaBrjZu4kumk2Nk=;
 b=tcZgQGKK/3z9QlrTU0NO/9bbp1Phl5p7G5t4o/FwV9PU0ndhzFInS8S82XjWSbjgzC9vFkQsSzgLz6j/ThBcZSmDCnA7bBUsq7MZ1tBL8PJewSOS0kTeGmljQXsFWaTtgFeUuhCawDzEx8B4bRBhHdg0NDfBR/fgu3UV9n2f7+sLRhICvnvJRm9Dts8i01EH4a2ikta+E1VwbRQsb6xp4DoEuNgR83G34csNdlS5/hTPjFK9wyNXp+aLwuSYk4kimXhWrApUFAfPyVNro9usEVdU9KnkgQUmXLg5PIDkeurDtDsFmtAy9qNQoPm1ymAdb2LQ2NhL+WizSv1vQ4jdkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10769.eurprd04.prod.outlook.com (2603:10a6:102:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 07:49:22 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 07:49:21 +0000
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
Subject: [PATCH v4 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Wed,  4 Dec 2024 09:49:13 +0200
Message-ID: <20241204074916.880466-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f442ea5-b6eb-4cc6-3e82-08dd14382a2a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0hTZTkvWnhvS3JNWWZmWkpibWRScUtQRzRFdnFMdmhjUU5xbFdrQTdTRUFY?=
 =?utf-8?B?L0x0VnlqemFUUEdhS2ZrejUzeWFyNjhkSmRETVluSnZzNUtMWG9CNkFxN2p2?=
 =?utf-8?B?ZVhPVGU0cUoxc1BZTjBsVEVpOHpGK05GUzRUM2tKUG94b3B1NXFwZ1FCOXRq?=
 =?utf-8?B?LzNpQUxOTTlGYmxQNU9TRzY4TXN5SmpvbWxGaXEvSERQMWptU1doMWkyaFlU?=
 =?utf-8?B?SG1Ga3cyVGhTdnBKTDJBMzFCY29PZng2ak8zVEx4eDN0Sk55S0ZHcjhzTFRl?=
 =?utf-8?B?ektKSTBEcmQ4amMzOU9MSG91eXkyK3ZITThIL1p6cSsvZDcyVmFndUJhM0Jl?=
 =?utf-8?B?bTdzUFkyd3N0aW1DRVRJOVYwMVA3NHl4cVZnaGllNGdvMUFCbnVyV0MxWnd4?=
 =?utf-8?B?K3BUSEdVeHM0OThmcnRyUmg2aUZIdElkSVp0UHlGbmQ1L1BYTUgxWk1YT2ov?=
 =?utf-8?B?NWsrQWJCMnczRGozb1NqSTM4QXVFMU8xKzRGdkNwREZIYmwxY25qanB0aFF1?=
 =?utf-8?B?UWlpbjhDbk1KR1J0emwrVzFFS0FQYkl3Q1JYaG55OXhtR3R5Q254dmtxTGNh?=
 =?utf-8?B?U3pBRmJFbTF5eUJ6ZUcrYW9nbms0WXBQN1lTblMzWnRvMVI2c2hSaktuRVBK?=
 =?utf-8?B?UVZJdU1mVi91cGx0akhDZXdsdkpadEdlQUx1MmhYREpjOThoZVhUOWRLSnk0?=
 =?utf-8?B?SnhtQ1VCZjZ1c2hPTXR2dklHM1hvdmpCQnBRY0prSDZOQ0dJNFFsZnVITGh5?=
 =?utf-8?B?b3JTMEtxM0x6cisvcjF5R0hOZlpoQWI2d2czUUNUTUFHcjB5UEVaZGpLcEpq?=
 =?utf-8?B?TnF6bTJoQzFDUUMxRnVYL3kwZ3oyUmhRbmhOT2pYTmVSckNpdmVnRGtVbDJT?=
 =?utf-8?B?VEhwdHhzaWNUZ0cwNzV4SmE2Zk0wQXZzcFNiMlIxek9ZUUZUMFBxYjAwL1Jv?=
 =?utf-8?B?NnZ0Vm1yNnJySU1tS2Z2L1A0MzQzUC9Wb1lJTThEOFg3bklJa0JyUXhTSVgv?=
 =?utf-8?B?ckRGMDF4NmFtZUhkNG8yYnJVRzczZS9tLzR1eVV5Y3Ztc3oxSkpsL292cUU2?=
 =?utf-8?B?dlRtWk1EeXlSdVh4K3dINXVyc3Zoc01TM1NNZUtnQS9CQ1pTNU44c3MwaDlU?=
 =?utf-8?B?MEIwTUFwUTdCR3R3QURhU2JqcTNUb1dPOFd5cWNQMGd3UFVyYi9BZ1FBT2pr?=
 =?utf-8?B?YS9PVVFlMHZ3WEJBNFpraXJGNlJxZE9la21EOE4wajN2TUxjV3lTRUZoSncv?=
 =?utf-8?B?UzJHNWJOVXhQWTh0NnFkcWwvOHBrQ3BPNmxFNU1hK1NxdUZXb3hHOFB3cmNI?=
 =?utf-8?B?b3hzbVhoaktuTks0TUhLVllMMld1bUtkdU8xU3J2bTh3Y0wxVHFJQ0FFSlZE?=
 =?utf-8?B?SjFzbHNzaHgwaTlpS25RRUVWakwzeHhDQWRQOUNuMFNwS01iRGpiQ2h0cER0?=
 =?utf-8?B?djIvZXhYL1FVeHFjTXFvQ0J3VXRYMGdxelByZ1RRVmlNeTlqVEN2U2NZeXFz?=
 =?utf-8?B?SkhJckNGa1hRSWNkZ1ZEbnBnNlJudzFBSE9ZSVNKWVhvM3hpZ05JeDZxNkVi?=
 =?utf-8?B?UlJSYnpmdFgxRmp6UlUwbFl6VUlXblJ6UW9WRW5yMWJ3WmhVbVJKTWtQQmtt?=
 =?utf-8?B?M0dBa3BxcXRKTDM2cDhJd1ZWTElZSlJ6b3BZbG56WC9BT1dzQldEZkFHa2U3?=
 =?utf-8?B?REN2UjZGQWFaT3N5VGdDazJGSHgvSjNmb29XSU9wdjByS3N0dTlWbURhRTNx?=
 =?utf-8?B?V2Iyd1h1cTB0THVhTGFBWHlOdVEvSzhhOW9JN3hXT0xpYWpCUXdBNlg4Q2VY?=
 =?utf-8?B?eGplelMrcm5EUlppMlhSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lWdXI2UEI4T1ZsWlBYNndhWUphWGFqejRNTmZzQVZ4M2g2ay85TkpCSEdh?=
 =?utf-8?B?ZWFLenNLamF0eHp2TnhKSUJrUUxVcDZEVU1qUFlkQU0zem0rdE1GNStmUnNo?=
 =?utf-8?B?MkcvQUUzODhRNUNpZTFpRTJWakhkb0xMN2x2S25tbUVIcXZ3WXFndXFUK2U5?=
 =?utf-8?B?OFhSTmpNNjE0ank4dlE3QXFaUUgzSGNSdHYvM1pkQnJRYmZ5dTZtYUhvL08v?=
 =?utf-8?B?SEVQNDZuYzFDeGZaTHFybXN2NnRLY0VqZnBQYmhnSWp5K3BobjB5cWJWNDJV?=
 =?utf-8?B?ejBkQVcvMEhzZWF4MVU1TEpiZ0NFMEdsai8wZitvcy9mYVJEWUdwb2o5Z2pt?=
 =?utf-8?B?UFNHd09TUnBVb2hzU2FIbmFRYWhpNDZZT29Ha05tbTV5VVBwMzdIbG84a2ZX?=
 =?utf-8?B?WEtvd1dZZ0ovWVBJR2lHVDdFeDJTR3NCeUhuVHQyc0p0NGxXcnhWVEF4Vkpa?=
 =?utf-8?B?NUVVK1N1QTVtVnNVVkhZb2s4bzhUSTllN0phcUlMUlpQaFRNekFkb1l6REk4?=
 =?utf-8?B?K2J0clJJZ25iWEhqZHVWRWFXSGwyV0pacUxHb0RTcXRERXRiQnI5M1VJZm9T?=
 =?utf-8?B?QVFNSmZ6ZXBSOERwdG9kMGRpZmF0RDhqblg3MnhmM0ZyVHYybXFBVEJrNDEr?=
 =?utf-8?B?c3lBQXJNTityakVZd3hHaDVFQmhCSHF3VG9Sb3R2a3dHVGNWM1VTZnZDTUg4?=
 =?utf-8?B?QUwwWllRek81Mk1pY2lrOVNvQXgrZThLL1c3WjBQa2t1c3UyckdvNGZFMHha?=
 =?utf-8?B?WGt0QU0wNTNsQjVxK0hDMmMxMDJkWVFLRE5SWDVoUzdKdUs2NXVuY1N2bGdy?=
 =?utf-8?B?LzhTaU94dUVoQ1JhRzRGMEEvWXJmak01ZUs3aGxKRC85OUtHc3o2UUQ1K3FL?=
 =?utf-8?B?RVZQK3g4SnBkV2QvQVN1WHhPZU5mQVpEL3ZaZVB3VTlnaFBubXhJcmNITjhj?=
 =?utf-8?B?YTFwQXh1ZnE1RkdqSlN4V05seGVpczNMc0VpVmZNQmFJSEZWZEpxTlVTZGRk?=
 =?utf-8?B?OTloRUt3TlNqMDg3YXh4VDIwdm51S0lPZWtZYzhEcSs0aHJaSVEyb0NRTERx?=
 =?utf-8?B?bk1uOVNnMXo1VlJ5N0dwNmxZMzU5VU5CZ3FOYlZWUk1CcytzVk9rSnBSZXJ1?=
 =?utf-8?B?SWVCMW4xZm5uM0JObklVdzNuelpnM3hlVVFNdlVvZHhoSzJlUkRQb3Rud1Bi?=
 =?utf-8?B?NlVqWmJvbEN2NHB2Qk9iZnJiclhLUkYrR3c0T2Nzc1lTbXh1UkZoaGtEZmdC?=
 =?utf-8?B?eTdyWmgvR3Bjc2g0ZFQ0NG5SQ3JrMGxmRHRuYkZ0L210WGlteWFzc29Xb0R0?=
 =?utf-8?B?RE01T3pla3BsUU5lbDl3REpuRFpqWEhUMHZmSXJBNDZzMVVRcDNZbVpwWmRQ?=
 =?utf-8?B?MDBMSmMrYTUzRnVndWJwaGp4MFhZaXJQcDZYZHZRUkdQOHI1M3NEZVdNamtY?=
 =?utf-8?B?Ymxoa0loM000NmJzbXNraVo5ZUJiTUZ0cHd0aUdGZG5DWnNuTnd2aDZvWFI0?=
 =?utf-8?B?V2ZabG12VDI1SkV4dUhMQ09NL2JvY0R2UTFhVHFMcDBzc01nZWtham1ZMEZR?=
 =?utf-8?B?WGVXYVNvWTZsSXlpK3l0VHNqMTYvWlZJcjRyNFJ5SVFkQWxySy9oUDZ5c2Rt?=
 =?utf-8?B?bmNtNG9yQmxLZ0NWUVVQanZCZTQ5b0xNYzc4ajUyUUZBVjlhcHliRkR2a2sz?=
 =?utf-8?B?WVovMVFLUzZNNHU2bjdXWk1IOGVMNjhZRXNUR3hqVzlUNUw3V1ZmNk9jQmZW?=
 =?utf-8?B?V2xjRnRwSDhTVzczc1pZKzRaTm0vNFY5Y2UxaXpqdVBMbU4zVzVuOGw5bUlw?=
 =?utf-8?B?TjVxQms0bDUySkpDL0lHL3NGM0dyTW1WamhYUExoRE9iK05aNGdHeUFTS3VS?=
 =?utf-8?B?Q2IzRzNNNHJyc1RSMzhBVFlLZ082TXhrM1NYNnhQK2RVbWZwdm03SVhmQW1G?=
 =?utf-8?B?SnZNN25Db0dkWWorUmNTNUFITkE0MzY5ZFdMYTZ4T01NUERtbXlRVmgvYi9N?=
 =?utf-8?B?Rm5pMmFaajFsWmRweG5lSXQyWEk0K0Y5M0NneExLblFkbTcyclp4T20xU2F4?=
 =?utf-8?B?ckRpRms1YnFtNTNyeEgwQ2tiSkpheGlMS0hieEZUQ0x2QnJ3R2VRQ3dydGxJ?=
 =?utf-8?B?aFBaSlVUL2h3NGNKVWRYVnhjSzd2aG5vaUNzYm5YVWdZSVhzMzY1V3pjNmZj?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f442ea5-b6eb-4cc6-3e82-08dd14382a2a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:49:21.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4f3W2QPzNUXk7q9Or1MxBZSxI0s4vOjSyV5T8a7Pb0sn1r7CKzkhzIsfNu3DdV8eWmN2w6miL4KXpxhQZdu8e2QfIEj4cNL7gmVZVLBZZsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10769

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


