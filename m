Return-Path: <linux-can+bounces-7441-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NtMF1o582mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7441-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:13:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35CE4A1923
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 127EC300AB17
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A4425CE7;
	Thu, 30 Apr 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TOV9+q1r"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66546423A7C;
	Thu, 30 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547249; cv=fail; b=Jj8D0SQpY4NepRVjFZ9/JyLrGpNJ1ZDE/rvc0SqZjgzCqsDLLhrb+LzYqJUuS6KjHchukiRtPFZxP/BThMm3E4Y6m/Ic3AHrtjH1va2bupPLfMeajmznxPIBVUrN33I5USGf4n989KHJrrQq7cOWj49KdHzl9KX0cfr92sdh9I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547249; c=relaxed/simple;
	bh=0tVi88mWJLSPw8/WUDkyy9yp0qdQFdUfVp2jPRDdZoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlOv02qIZ1kub00L884Y0+PpQ9alu/2wQRbD9Y9ihkcgsn8xLH5Fv2PWulGus76kaCsPBplluLOlQCteyCocpG3N1z+WoZiD97x/kQvoWetpk3VO2SjMGP1WdXVhY9YhZtng/fhNDoLOsHSxcE0EdSMr/UcZdTjoOxjvTOrYAKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TOV9+q1r; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJePuW3H47VYLIPvSGT7+Z0vF9llBL8Toew0zzUsLU5/0nUWcrWxv+ptHqmRgJwJkgK/JzUSKvBf+MsnXkuaC8uNKdKVQWhiyUqqRZxIeV68Fxeid7Z5JKpbhsInE9tsQv+Eue2XHTQvddrWhPqbS1BzOxEtRh1cQTW+QiDUaBlaMy0qWv+o899Dptxq1e2O+AUKWQOLZoz+j20Oh8YkN4iC6PmAvI1r4OdcAlwANTiPzeJXavcJIC9+rzrXe/fX51RCgR3F2yp0MingL3bK3+AatjOoxxmfihnCYkcFF2ZKTnGuqwpCH3DS76ewBf8f4jPEAtb/r5H7leWEUYnTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIWImDhFoFRUTB1MQmQH08WbG1zXPmUNoZw37U0hNq4=;
 b=ZNck74F8N75zWWwjtoqVsq3EJNWjIAlfXr+6IKgc5txb2DTJM1GNF5uz/sUL5oxL3ycQK9ixaXgcE3P/G99VOco4tKxVzS2rilnijA/t8yCrDabgTAmmYe+rVU/NBIQaHPkskshrAPZDoXhTXR+1pSjLSFWKQvY0pdJ8ckSPBO8OOlS5AnvIQ3CLkX9uTqtTi+NA9mPnBfTb3fRvHThHZlD/BtONhRvbM0qbvkkLky9Oxw7pduJ/oruPlCSFiw0NWqwRE5AKAElB3owi+Dr6Jh8OWJxXX4QiZ7cru1j9DM0U2Z5wpjcVZP4x2EIPLr6DkK6Bkry/tX8jH4amXdQRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIWImDhFoFRUTB1MQmQH08WbG1zXPmUNoZw37U0hNq4=;
 b=TOV9+q1r/Yj8Ijr3K5hKEjO/eghLo5OPUvlLixTC+WNypF+vbxWZ91Y1J7xn0uQ7X3249UhcaI/M/qm8xV8Jiu9o1FKMp3ESP2Ak97XZs8ZT7vVyEbshU13zVx4ioPuy9o1GMY3XpFLJQ9YLLCLUL1qDFq3qaZWNs4eyzWFsJlbOdrru/oQZQAZSzJlNevhAw4FlzEZgQK+0aY0/d0i2+d0IdVTmjCMVrzDRB6UYm+SUN6hq6IMz2jlRpZCuOeUSbTdKRYZdwk/1QaIB0avmL3BIzK0n0WQLdft7sfAoYbX7c2asW9ORooKQgle+5bangk4f4pJKwkwGLRtLpzdwjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:17 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:17 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Heiko Stueber <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 phy-next 12/27] drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node
Date: Thu, 30 Apr 2026 14:06:37 +0300
Message-Id: <20260430110652.558622-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: db646d73-fd00-4d41-3668-08dea6a8a431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IVUr3iPHMjqRHlgO4H8Az9DKhkUSAxhJOPyaD8WBtG4rkKLcdFrpE/XuBgy3eUL5x/uQZqgJM1C8NKBTFZ5UvR1E0fimyaqAliifN9KUJneC0XQXd86O3/e7sdGhfKPxQ6hEBKJxg1LTbu+icQyLXh4fI1NS8lQAO/BFjhv9xrUZARyJ0NQt152qJWsG7gQuZr9haBm0ib48NC1Dukexh88LU/A+8D5UNro+iKUgMqI/hS/lri0fMTXPLOnDJ3fpffUX3zG/etTnblR1EVjRK+CAFT3TlfXR491eDsqyDdDa7Yj9U7Oh1PZaaPS1bqwUh6edo+VtphpuF8w/GD0zmLUwKlYpQ9iK1ljV7456VX3Yu6JmAZhTRgWZlsXT6cXBE18kiloMONbQJPoqqRB1DtY//2yw5FV94njQwdnTMG+VJj7fQS/kPCPoobf5YW1Z2p/4OvWwrzL6CjL8PW5bF9+JsRAVNwF/erHJsXMcsb8/9w+KMPWJoKQz/PISJwqJDVVBbazt07O26KmJeyzoh+VHDQHgDthSTMs7wRP6xwZWV01DZ/Jw5sj2jr+K3dYa7MzduySNJe6eBX4OKpzAgCja+BM5bctTdrDKMNUAVjZ74DQq6/0zVr5MXAnPFdVF4H51rTNEniqppHIXN/R7R62KpUpie38X7XF9c+3/4OQ/Nea+HyOUXysrvqZ4yCE5II1UZ7Xo9XrjRHP6tjdvioR5QMBJO90Xd1kXrBtBdks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE5YdmlwZ3I2RGxLdDM5YkNnOENaWVpxY2U4VmVjTWNrc2VIR2M3ZU5vUGhl?=
 =?utf-8?B?V1ZLWUU3TWo0WjE5OWUwNkhWY1BuTGZoUFpwWU9valNpLzFwUXBvUmc4STFr?=
 =?utf-8?B?aFJMUVUyTzdWb3ZLOHNXUmR6bE96UWhOMHc1V21VM09nem9VWWd2NS9BVGV2?=
 =?utf-8?B?dUY5NVF5OCtyeGNVWUFhN29tUURiL0IwS0tVakxVMEFBc3RPS2tieG9KcG1K?=
 =?utf-8?B?TTRWZ1pNQVoydWJrMHVoNFZtUjFBVFRTYlllRVJCWmdzRVlHSjliU0Z3UlJF?=
 =?utf-8?B?anJ5azFIaXBRUTlSYmJ6STNVZ1BPdU5pbUhnOWkzUGYwR3ZMOCtUVG1mTWwz?=
 =?utf-8?B?bHc5b1l4WTdvRUcrUy9WcnJkMnIzU1dqMFNzaWg3MU1LbUU3RndlQzk5dmNP?=
 =?utf-8?B?UXZFclJnK1plYVlSRUZmdzROYWdDOGp6K0tsVmJOM3hJTVlaekJlb0E5UjF3?=
 =?utf-8?B?Wmd0UEdWZTlFdGJGVVJvNnRYaTk2akhydGZoNUJmSzhzbTNNUi9IWkFJRnor?=
 =?utf-8?B?Y1RhS1BGUXd0YzBqbWp0aThCb1hFRFBDeE1GaW1ZYWExK20xREVLbHpmcTdE?=
 =?utf-8?B?aVNnb2t6QVhlS0ZxUnExQWQ2T1lHR0s4dkFTMXVybUtNdmlTUnd5b0dDT3JW?=
 =?utf-8?B?eVBQTXFOYUI0bmptUXova2dYQkJveGxydm85QzRFOXZ5c1ROSlgvYU1TdHNL?=
 =?utf-8?B?eEpHNVk4ZnRvSDFRbVBVaktTV1NVYWhWdXEvdlpPSnVVajMwUlp6N3lYVGZo?=
 =?utf-8?B?Y045b3RHcklqUU9aYnpvY3NJNkNuY3RFNHVyY01YVTNiYThlcGpHbXdsMksx?=
 =?utf-8?B?NGgvNDNMYW1hVG9CQXJoVnJGODFVRy93VVBuaXJqamZINVpaQmh0dDJ3c2Vt?=
 =?utf-8?B?RW5EQWhlRTJvZ2ZFWTE4MUhacDZKZ1AzUm9MN0ZtRnllRDF0bG04b09PZ1NY?=
 =?utf-8?B?c2dJUm9qL3ZkWjZyRDc2SnBhZC9qWHF4ZHU0SlF4NVIxZGNjTXRicmxwOVgy?=
 =?utf-8?B?V1M3N1grWHZmeHE3S0xvMWM3WWxXMlYyR1hXbWp6MWtXLzV3UmhSbFJ3WWND?=
 =?utf-8?B?QnJBbEVTM1BYaXo4VFEyM1VmWWlJeHllMzhaM1NtTTVQbU1WYk16cU9YSkYv?=
 =?utf-8?B?TDEvSm1YK1cvSE1kOExVUVBFMi9ueW4zQUEzWFNKUWl5U0pGeHE5alZ6Y3RY?=
 =?utf-8?B?VitGejkxaXREcUxWazZpbUUzUmZiZGdybncwam94cTBodlg2M3ZIYllJald5?=
 =?utf-8?B?TlBNQThLUDRVR0NubGpwb2F2S2xNRUlaRWNhUWs4WDc4U0pLSXZkZlZmQWsz?=
 =?utf-8?B?ODd2T2xJRlB4QUhOUUtDbDVzOW5XVTIwdGhIY1VVb2E3WVlPbmh1TUJrSDYr?=
 =?utf-8?B?cGFKVHRoa0I5N3J2QzM0bVl4b043YkJDY3VKQVhwWE0ycld4YU9qU2dlVXA3?=
 =?utf-8?B?NGVGMUJHajV4dndxK1M4dFE4aWt1V1JjNXRXQk5XMnNjSDIxek9TdllFcGpP?=
 =?utf-8?B?NWZIakwwczNuVHlzTEFSVEQ4QmoxMUI0QnJROG9WdWh6QkZDazl6RFgyaTJm?=
 =?utf-8?B?WEoxR1J6TWRxcFgxbFIvUXdJWk9xbXZseU1GZmw4QkRFQjQxZ2dLTFRnUkY0?=
 =?utf-8?B?MHprWGs0UERaaTdsdVJVZHVoWUlRN3ZqT3g2RWNoWGNuT3Fqd3RISmUyQTQ0?=
 =?utf-8?B?dUI3TDI5Z3krQlh0RTlTV0ZsU2hTbFQwaEZPMVJXaHEyZyszRDBleDJqVEdD?=
 =?utf-8?B?STlVODlwcGpMY3AwUzU4NlFSN0xqb0JaZHJJY05UTkE5eDJid2RlVG9yb2ZL?=
 =?utf-8?B?bEhxNXFJTGdrbm1ZY0xSYmdtcVNJSk5NVkQxTFNRLzdRaUhwa0twQjh5TkJo?=
 =?utf-8?B?UGNKWDZtUFEwZkpjUW9kd1RIcUpoMk1JaUlMTlV2UVpKSXpMRlYvVWVSYW5I?=
 =?utf-8?B?Q3BSS0xYZ3JTVHFHaU40MkFHcmYrSnNuVWtEUVltM3dwWFErbi9UenlkRS9Y?=
 =?utf-8?B?NEVUdURSZEF4WnBMbW15SndCbXdqT204TGRLdENlQ0cvWUdrazAxb3hGSkYw?=
 =?utf-8?B?UHhzV3lSYUlZUUFvZzh4SG9XVGZCam5COG9FaHZDV3lNcFZmOExqUm5oNnA5?=
 =?utf-8?B?RHF1YjJXQ1dNRkI1ZlhXUHkvb29aUzBNN2tCK2Q0Z0wxRDYxbGtsL0J5NnNQ?=
 =?utf-8?B?Q1JHZmFMSkhucnpYL0hWM2k4TWEyR0E3VWZaNnMwckppRlBlbVpHL3VNajYz?=
 =?utf-8?B?UXFMZE5CY0FPMVRYRndzdDlHUjJ4NG1JTW9SaVc5YVF4bFd3d0U1VUd4UVNF?=
 =?utf-8?B?dUJkRkZPM0ZPTXNkMi9SZ3I4WUFBUFNjT3dsMkdpSEhDNGtuK2pReXE2WnFJ?=
 =?utf-8?Q?8KRej92DgZHDTgXm7exCTSOp328P31xJ8KgQN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db646d73-fd00-4d41-3668-08dea6a8a431
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:17.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tezv3psilxXrmigSU/eM7ogguU80nYMJxJjVEs+eMYMSOE11cy3ZJQ28Bqa9MlyEvBd+9ZrAh1nP0nnseilUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: F35CE4A1923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,sntech.de,rock-chips.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-7441-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,sntech.de:email,ffwll.ch:email]

The dw_hdmi-rockchip driver validates pixel clock rates against the
HDMI PHY's internal clock provider on certain SoCs like RK3328.
This is currently achieved by dereferencing hdmi->phy->dev.of_node
to obtain the provider node, which violates the Generic PHY API's
encapsulation (the goal is for struct phy to be an opaque pointer
with a hidden definition, to be interacted with only using API
functions or NULL pointer checks, for the case where optional variants
of phy_get() did not find a PHY).

Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
on the "hdmi" PHY index within the controller's DT node. This provides
a parallel path to the clock provider's OF node without relying on the
internal structure of the struct phy handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Heiko Stueber <heiko@sntech.de>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v4->v7: none
v3->v4: add commit message clarification of what is understood by
        "opaque pointer"
v1->v3: none
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..7abb42e486c0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -537,21 +537,22 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev_of_node(dev);
 	struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
-	int ret;
+	int ret, index;
 
-	if (!pdev->dev.of_node)
+	if (!np)
 		return -ENODEV;
 
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
+	match = of_match_node(dw_hdmi_rockchip_dt_ids, np);
 	plat_data = devm_kmemdup(&pdev->dev, match->data,
 					     sizeof(*plat_data), GFP_KERNEL);
 	if (!plat_data)
@@ -564,9 +565,9 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	plat_data->priv_data = hdmi;
 	encoder = &hdmi->encoder.encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, np);
 	rockchip_drm_encoder_set_crtc_endpoint_id(&hdmi->encoder,
-						  dev->of_node, 0, 0);
+						  np, 0, 0);
 
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
@@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
 	}
 
-	if (hdmi->phy) {
+	index = of_property_match_string(np, "phy-names", "hdmi");
+	if (index >= 0) {
 		struct of_phandle_args clkspec;
 
-		clkspec.np = hdmi->phy->dev.of_node;
-		hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
-		if (IS_ERR(hdmi->hdmiphy_clk))
-			hdmi->hdmiphy_clk = NULL;
+		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
+						&clkspec)) {
+			hdmi->hdmiphy_clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(hdmi->hdmiphy_clk))
+				hdmi->hdmiphy_clk = NULL;
+		}
 	}
 
 	if (hdmi->chip_data == &rk3568_chip_data) {
-- 
2.34.1


