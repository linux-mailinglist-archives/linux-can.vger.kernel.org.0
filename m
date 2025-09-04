Return-Path: <linux-can+bounces-4465-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6AB435E4
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E101BC896C
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51E52C324F;
	Thu,  4 Sep 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XtPlzlCD"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43B2C21F6;
	Thu,  4 Sep 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975036; cv=fail; b=kIhtavdu+pdvRxW82T+FJkWhwJ8KuzkiFvZRotsPxm5EWjInFRCJUd/kjpGw4yxNsK5Zr86q05tyy1Q2IGduF3pVehKUvE/XnX8YqooWUpxaB5ZPA1/Y6Q1E7vchLHZT7C3W9yAOGD8DZzdrm7No2GF76HdvsNtzzYvMmLhKbdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975036; c=relaxed/simple;
	bh=xnxTkBP7envEvllhJdwuR3afwp50bK2E0VD//f4iw2w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WCQwB4L/jdT3ulrZsMWEqrA2CYmfyWrLt3LHncW9SydXjHKIxBnkeIgSJqcIwc89/UVBpb+r2sk8kMn5XDYDXCp2Sv2i2yytqBU3+WERjc7cdiBTyCxczw1YB30JInI+JGyvoGDf1xz4n+TN1PP8FNn59Q4teZwGJg1WmsdfLi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XtPlzlCD; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IURwvpOsVPaeTt19L70H3E1biGzQtzU2Sd9Hq4wdpiTaQiBO7+ewtOlDU+SSoki25qynb+pYjPGWi+Xk5C0A/UO12c9aMut78oUTaNADE66WZa705ZpigsA/u2IDHnlgKddFlvJca9omnNZf7NYXn3kaK+GUCbL63Nqp/Y14Q1FBfJxs2vNHrIy0puPxG66X5fqf1bbLUBTaJDDVLYAsKBlFbjo9Qc/b8ePM6E9FMQGzD0C/qPerQTjw0OswBBZpQd4X0hCwZDirsE7MexdyUU2T/pBUTtwrYysYt4WTDkBav+eTWaEhkEOWHjcQnxXsurK/rmRWQWKONbc4ZC2fUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j9g1i4pSr9VB0nIyzu2sUu3AUER9OAeZo6fG6YACVY=;
 b=iB21/EeeC9L2KHPWUss8jKmA0HcIPZ+qjfWfB5fUBXwrmPU1XrnPBKwKcldL53TLujqGZ306HcjRBWnhKCJpRIOE79ylt8H887wl2szufsXT9vKHJSAsXAyz+Mdjoom/wvnw+6lVv4yYgCuKd+CzJRp3hnhR9RV0Wl3HMiyZtZ3c3sVVz2517SVw5ESy8CYzG2Kl0KahwHFkgYnT2Xs1ZWT7RvbOP/+rxSTxmhjOtiGwppKH1ggum+p+DS3plRR2bbP+24rBRvhxwtcLjF3C/tvchB8qIS8IJ9ofHWHSKSRGfc6qrK4RXwCFLQMNgXB5RDAkrpSdBpeRrN7xkGNvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j9g1i4pSr9VB0nIyzu2sUu3AUER9OAeZo6fG6YACVY=;
 b=XtPlzlCDB7f+grgfb5foEAsrworACp9gdYJA9mHRJSpv9MUbgohgyrzqhHtZnsBLiMZstUsmAqMQe0OEg8T9Kvjt5QBnOdDET9mq3oS6yCo61LqkRXR6FBcUW2pbG+npQsI/YlAcDIB+58oC3/3f4nGnSo10FJdkmaUc1tVC8v0sDyqfwMe1D3fdgOQP8BVqCcpzgTyLAEHNRW8U4yCSFcGot84bKwR0QKXAxvY1jk1wRiCVOiveOaAVvzc2U5J/4Nc0YuMZnpMIbhzEj8aKkekKQfJUqZpLol9F453YS9h1PF5w56OsVSKCjcZYP/kBFZYDI605UJlCWU1nJ8P7Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:12 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:44 +0800
Subject: [PATCH v5 1/9] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-1-23d8129b5e5d@nxp.com>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
In-Reply-To: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=2839;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xnxTkBP7envEvllhJdwuR3afwp50bK2E0VD//f4iw2w=;
 b=AciXHk5CXTJ83JIblmeIF6OwyPsn8GXc7JrE4pk6/ssl8kZ+2eHDiwCRQOrVugPuFJrkgalCp
 9FcpFjUHeuoBECq/4fqH9V9GrbBCIUPG7qXQlPefHbNYbH/1fvH1zX2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0ee9ef-0c9c-4727-505a-08ddeb8e3e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmVON3ZjV2RZa01HU1A4QytrUnlvRHdCQmYwdVppa1ovN3FuRmdZeEEvUTNL?=
 =?utf-8?B?VDE2RFZMa2kwaXBnYzBCeXBOd2swTnZOMDZHWElqYys4RWVzY282aEJRZkhD?=
 =?utf-8?B?OVhHWGR1OVd1YjNOdyt6S3VZLytiRHRLTy80TEpLaVhnL1lxcXJRbm9wK1RT?=
 =?utf-8?B?OThDbnRiMG1vQ2VpMUkvMzJxd0JxeFlQWWdoU3dMNmhzY2hzZSttbzNaOHpG?=
 =?utf-8?B?cHNick9lUXFMNFdadnNLRXAvdWxWTVNaSnE1dnNQMktXbU5KaEhLaVc0c3Uy?=
 =?utf-8?B?dGo5N3EvcHBaUkQveDIvRWRQUVhiMjJNRC9DaithSjlhekZraU9WekNybHo2?=
 =?utf-8?B?M2h0VXdMVnZUVkE1TDZHanFDZExFSXA0cWNRaTI3c2haQUYyclZWZ0tZdDRu?=
 =?utf-8?B?SVdwU0RZRWtZdGFyd2RwZVFzOEVlYVEwbUVrWko4Uzg3aVpDc2RDeXZOWkN6?=
 =?utf-8?B?Z01oUXVtdTNUaFlmTGpNZXNwYmNkSDhHdVRBM1duUncwSmNISFY4OW4vQVkx?=
 =?utf-8?B?bmZXTHZBaE5wN0tvODNCekgrdjNXWkpIbnlONWhnRmU0OFFWK2FMN1VjcU0z?=
 =?utf-8?B?eTNQbGoxMWpiRUpnbnBYVTQwUVF6RlJRbVgyb2J0cFYzWVNSZG5nVTlsTktm?=
 =?utf-8?B?NHBxKzY1bVdVRnpORVBaVENUeDcvd3Vrbnd3RHFIbDRpcjlCZUpGSDIyeVBh?=
 =?utf-8?B?NExoRGhSMGk4MVFIb3B0dVgyWFYzcjJyM0VtNEx5a0xwbmFTSnEzK0lnSjlv?=
 =?utf-8?B?OG1mQTN1OW1nK0xqT1UrblExS2ZwbkoxdVl3cWJMRmZKWTRUOHpxaUdWdVJP?=
 =?utf-8?B?aHcvMzUxdlVFbndSWCtEQmhCb1F3MXFMVWQ0N0V5Q3FzL2VhejRNSXRxT0xF?=
 =?utf-8?B?SzBuSGl5K3BTSU1ybG16eTRVTENFSkh6bzBRNG5td1ExTnBwc1pQVFhmTVBv?=
 =?utf-8?B?SzFnV0grdE9RZm9CTDd2MFEwaE5vN2R1MUFodDBoUm55SG9oanI4c3N6dW0w?=
 =?utf-8?B?Ylk0bkpWNHJndmhQWXc5eTA3cXV3RklSZjFKdlJ5cjNrNUErdERjaFRQdTJR?=
 =?utf-8?B?dGlmNnpwVFIrUEpScjVDUVUrMVVIbzNnS3VLRmw2TmZFUFN0RzlwOE4xVUtk?=
 =?utf-8?B?ZUJESEFmb0xoOFVjMXZweHhCQjd4M2hxbzV1WFByQ1lzZUtXQjJaSDFKN0ho?=
 =?utf-8?B?RDd6cWZqcCtjWE4yR1dLdjFzUVNmWEhRa01HcEdZYVFDL0pEUjd1Uk15YU1l?=
 =?utf-8?B?MjVpR3JnT1JLL1U5RmF2eW9mWWlYbDdVYmI2UnNFbDh1UUpZWXF3UWVuYW13?=
 =?utf-8?B?NXFoakN3clpKcWlrWGEzR2RJL1FhbVZETnJCUWN4OHp6MFNkOGs1SE5tVTFI?=
 =?utf-8?B?SFZYbHBWVVoxYUtzelpZK3NGcm1CUG9PNG9RZGhXT2t6QXhyN2g3S3RQVGpr?=
 =?utf-8?B?d3lQclJ0anZxUzMxem4xT3pqT1IvV1UwdnhKR1prT0RidUR3T0pBUytHSnRy?=
 =?utf-8?B?UGVUYVhPdlZaSEc2d3pESDdkclJRTHBueEF6YWxJQ2Rmd3lLTEZVdGVIWW9x?=
 =?utf-8?B?RzBqdHVnTlZCcGZKR2xkbitoOThyVmIrbHNRK2Z1bHZFclRvQ01WOE9KK3k1?=
 =?utf-8?B?SGRyc1JjNnlLMnB3VlZreENXeEZweEpIYlN3UFRoZ1JOZTU4NWhaR0FmRjYz?=
 =?utf-8?B?TzRVeFVQZTlGako3Ymg3ZVdHTmp3OVdlNW1TK2FsdE0weXJ3VjAwbVZ1UFpQ?=
 =?utf-8?B?amQ5eDVnYXZaTjd5bTJXZzJyV0taVWtFUXlaRTdwcks1TmRVUHFSWXVXNWlm?=
 =?utf-8?B?Ujg3VHBNSWtWbXJHdHJ4RTczakZtbXJmNE5JRE9zdk9VcjlQV2UyMk5KT3k2?=
 =?utf-8?B?bGNGYzRXdFQrVDFVYmp3SmFsWjNrTnl5TkZJa2IzQ1MySnN3YldjNzNKaG9y?=
 =?utf-8?B?Z09xUHg0Zlp0YzRERFBmZnZPMVpEbXBsR3o4NEI2cnFKVmtrT1VDRTlwTE9i?=
 =?utf-8?Q?PK7datI8gEX3uDoKDfOz9OV/Agx3Gs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTY3QTVYUngrVnNncnoxRE45Q2duUnlkWG9wRTVQRzQ2ZU1TWkJTbkt1UXFP?=
 =?utf-8?B?cG5Id1ZzUHhxVnhZRlpwSlJ3Q0hkSlIvT3dueUtMTlM3RmJFZFNtblcwQllo?=
 =?utf-8?B?YnRpRzZzZTFibWxJb0JjRjdqVXptZ0lVd2dOM1Rla2FOSmJiZ3dLSlZkNVhw?=
 =?utf-8?B?aVBnL1NCTnJYUDU5M0t1VXRVU2hnaEpBOElONjRUamxyVE1xUkhYVG14ZC9o?=
 =?utf-8?B?VENKampqSGZwMjdobHJpaFJIRjdFYWltMDN3R0dVSmR3QU1TeXNjUExrWU11?=
 =?utf-8?B?MS9raldLSFVJZDliTUl0NFlNTWphUjIrQVh5VnRPZUZnc2FuNjMwTUdrYjg5?=
 =?utf-8?B?Y0lnUE8zeUcxU1E1ekpZN1VnQ25kK09Nek9BazdydEZzWFdITGk4Y1o0d2Ra?=
 =?utf-8?B?OTBENkNpTWRSb2oralVycnpaaTE3RjNYeDVONmdMTzF5WlZuN0ZwRldpWHpa?=
 =?utf-8?B?alJ1WFAwK1FRY1UzU0czZU83THhkcmdscnFIQTBERzhZeTNzWlBOS2p3T3dQ?=
 =?utf-8?B?R0kydzVRTFE2cFRRWmpPcE5vcnZqS0F2N3VtYXNjTEtleFhNalR2SVNVeHRw?=
 =?utf-8?B?NGcvSWppcEZNdnluQ2lwSkp0aGliNTJabFZQWmFzd21BdUNrY3lhM21FTHBU?=
 =?utf-8?B?QXZOWG1LSm9KOHZwRXBXaFA5SXBYMGgvZy9OOUp6a1d0QkJZa29QaUtVblVq?=
 =?utf-8?B?aTJQWmwrWEk5cFdzWXhSSU53ZkdJTzl3TnlVVkd4a1Fpc2dGZzFseXdUMk5v?=
 =?utf-8?B?NTlGRUJMU1FjWm1TUHMyQS9Ick4ydWg5K3Y5a1lvcDdUbk5RbzExTVc0cU5n?=
 =?utf-8?B?NVI2VFM4QlY0ZkRhdFUzWlcxRk1tQjArRWc3U3pYN1d2a1p1K2FodlJSTUwv?=
 =?utf-8?B?d0FESlVlZmdJaUVQOVp5ekJ5UVNYZEFvZEgybHp3Q1VtU2FuczdWd1VtUkdO?=
 =?utf-8?B?S09SWlMwQ2FvekRJVmhnc1BRMFRjdjl1NHhyNXB3ZVRDekl6Rnk4VmdjRW1W?=
 =?utf-8?B?Uk9MY24zSXlUc1k0SzJUQUhwK0J3T3hyTVZvRmw5Q1paV1hlWGRZWlJhZWJS?=
 =?utf-8?B?amU5YVZPcy9nN0JlK2crc05WTE8vek1NR3lUcmR4czhMMXVWenhEbzU5QmZr?=
 =?utf-8?B?R24zaExadkdhQjFmRFRJWTNHdmduR1pERnNrbGltTkhDWUpIZyt1Wk9oU0lN?=
 =?utf-8?B?YVpVdG4vRS9LOWZhOFhTTVNiOFJmNGhYQzNXY0l3VHBkakJrMFMwbDYwcTBL?=
 =?utf-8?B?R2d3QWlNTG1mdWVSeXZrZDZENGxDQk1qNFZ6eUpxVnJyK3ladHB4NExuZGNu?=
 =?utf-8?B?RVpYeUZaYkFGQWJWMXd6ckFQS0ovUWdBVll0VFIwZ3ZIZFFhWHcybDNMRVpk?=
 =?utf-8?B?WVNENjBRYnc2dEprZWUwV1Noa3NyTTZIbDhHcmFwZ015N2wrNzNJRWF2TEtY?=
 =?utf-8?B?Umw1S0ZnZWorUnBsOWJWalJsdENWMkpTSXB4anF6cWxHVzNEb25FWGhTS3ZU?=
 =?utf-8?B?OVF4V1lmbDR2WGVSR3lVQmpBZ3hLK21JbFRMaVVoVXlFTXdwRWVzUHViSnJl?=
 =?utf-8?B?eE9PUGMzeXhVemdNMWg5ZERZUmJrRjZiR1hoSlhHaW0veGtnRzFVV2lMZmF2?=
 =?utf-8?B?cENqaVBBQjRQSVpKVGlITUY4R1RCMHVJUW1KTzJ5bHkwZU8wQk5UQ1FaT2p0?=
 =?utf-8?B?cmt6ZXJ4YmIvaWdQaGw0NGlQSHQxRTM1MCsrL1NWQTVCZ2VpTUx1d0dRenY5?=
 =?utf-8?B?aGVpZFAyTnNKVVVhZlJEeGkyUWhEMlZoRjVldlhOaThpb1FkZWRaUksrcm02?=
 =?utf-8?B?MFRnYm8zNElaUThiY09YU296T0d6SjdXazcrWEhjSnhVVEJENkNoZlFleHdW?=
 =?utf-8?B?U00vRE9XcmE4RldOUUZ6R2psai9weHBYYVFmT1Z1M3hsLzlHMmdwdGxWMEdD?=
 =?utf-8?B?Q2Z0blNLTGNTM04zYmg2RDlCNmMvSDBBbHgvdUk1NWJKdmpMZGhpVVdzdThj?=
 =?utf-8?B?RnRCVXdNT2NwMVdndVVOaXVBazU5dzhST2ZNajZoa0RiUWZ2ZGZpNllNdUw4?=
 =?utf-8?B?V0lTdkJ6akZiNDJGNXU4elNMRlhKZnZoSi96OGJPWGRVOGgyTnFlN0RRYWQv?=
 =?utf-8?Q?IXs/zZqPYaJBUNAowlrhZ6rKy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0ee9ef-0c9c-4727-505a-08ddeb8e3e36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:12.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzHybF7QFFyJakfnQEl837VkjSVsp2j9GQumN82Eu0wP7GqJcJ0I71KNyp7/KZnHYeBrdmim96x18ntUjBGk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported
and no EN pin.

The TJA1051 is a high-speed CAN transceiver with slient mode supported,
but only TJA1051T/E has EN pin. To make it simple, make enable-gpios as
optional for TJA1051.

The TJA1057 is a high-speed CAN transceiver with slient mode supported
and no EN pin.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 69 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 4a8c3829d85d3c4a4963750d03567c1c345beb91..124493f360516eb203e8711cb96789258dd01119 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -22,16 +22,26 @@ properties:
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - nxp,tja1048
+          - nxp,tja1051
+          - nxp,tja1057
           - nxp,tjr1443
 
   '#phy-cells':
-    const: 0
+    enum: [0, 1]
 
-  standby-gpios:
+  silent-gpios:
     description:
-      gpio node to toggle standby signal on transceiver
+      gpio node to toggle silent signal on transceiver
     maxItems: 1
 
+  standby-gpios:
+    description:
+      gpio node to toggle standby signal on transceiver. For two Items, item 1
+      is for stbn1, item 2 is for stbn2.
+    minItems: 1
+    maxItems: 2
+
   enable-gpios:
     description:
       gpio node to toggle enable signal on transceiver
@@ -53,6 +63,59 @@ required:
   - compatible
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1048
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+        enable-gpios: false
+        silent-gpios: false
+        standby-gpios:
+          minItems: 2
+    else:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - nxp,tja1051
+            - nxp,tja1057
+    then:
+      properties:
+        silent-gpios: true
+    else:
+      properties:
+        silent-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1051
+    then:
+      properties:
+        standby-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1057
+    then:
+      properties:
+        enable-gpios: false
+        standby-gpios: false
+
 additionalProperties: false
 
 examples:

-- 
2.37.1


