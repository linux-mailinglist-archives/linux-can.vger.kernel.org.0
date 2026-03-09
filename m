Return-Path: <linux-can+bounces-7037-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ChTHLobr2lzOAIAu9opvQ
	(envelope-from <linux-can+bounces-7037-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:12:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0555423F5DB
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F05E305E386
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6983F076C;
	Mon,  9 Mar 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FD6km2ZJ"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B613EDABA;
	Mon,  9 Mar 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083384; cv=fail; b=hx4skmBdY4Sioh6236ZhHAvJfFwTC/lXK+C3II09UPyVhxQvxvpKc1Haflcnlqhhwkvz7mC0YwDS7kkWwvlB8uzIIlZqb8SeeU0W0oxdcUfFlBJBcsJZn7YWOfhAOogY4UYzfUTA5ZpySR9Rr3RlfZhOtXtte1/e5n/93Vl/tEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083384; c=relaxed/simple;
	bh=DNVdHvtaODP1EQje0BMvE+lT1pjdrOBndHPz/7rCees=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QgSYyCIDdnztoK1WQKW4ZZOFYndRB6TdRgfp2XBza9YrjztH6mYYIOYtefqklIEcQANj8B0Z0LfpuDIiO6CawKmBEOK3gFpFGGzkOm6kqE/RSnWm8Qp9lWW/0jxf8WW7hSvqYYsUt9/zMemEL4vcaR09hMmKhufXI6WxDEp5f60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FD6km2ZJ; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0x8fzaQ9LBEfJRO/ZP1+fPxCWGZLPOn4ffhyycS8wSFAd0CENRh9I4r7KzNZ6JTQSW3gDeQOcsjuT0ey4GtFvmhI7irkuxjZuBl6BKEElcEOlvtgT/2WhWMjWy+Z3S3JrZwBpcaTevvgcS50MdDiuPBbQD3vvefQ6JKzx/9NWLkbkjO5xZ4wfP31GXUehIJACpAqICgANsHMRxIqMyWI6AXdy6m0AMjp93a5R8uoIbdFDt6fSYmY5MhaJUcZ7bkTl1pqnnTtH2ROtT77N+9U+ph50TJdN/DqMp8yAnRL23lv+5OUMsucTtagXnt1SRv8f9sjeYW1/HtGZS/Y9Rm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyIQZr+rDW6jLC91REqJJkAGNC5vWrLn3ug122BI95M=;
 b=F30Hmg2rM5eJCtE6FOSHiBEa37HCIQnfaXmAvDPC22Fi0KhZyzya1VQlrStfkqcRR+YOjABGgq+eJXseJG5eowohmjhweT585QzcpCfZOc74M0/bLN37bOFGvr7nBmCOg7S6vIy9F6KnR0Q4ALyK0I+mYKFBdYDCx8EyUzdr+n5nTIo3JAMDoLX6xlZsziR2Z+0kKwOZP5t35eVXgZQNc/F0PwsofQNypU4lUN+DZNPwYUELkSOnE74C4O1KJoUgn1Zpr1NkdVzBuxGK8kGjJKapcJn+ig4FNQa+yaPWl62b/BV5IrUuy1L14zrPOHBIoRy9IkqKEwDRJvtQpZ52ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyIQZr+rDW6jLC91REqJJkAGNC5vWrLn3ug122BI95M=;
 b=FD6km2ZJIX8hR9f4lANPRinp/YVJrj6y5/+pAoCFJ5OU9goMQ9e3HXu60mOKsKblgJmItYbZdUPyXy5hybky0qZfUeJoInoSKrbNeYrSDUfiSyleVHaLnH5bZBIyrWzoqq0NKoj2nCO0+Zbicb8uAB1F4Bwq+dlUoJ6NcJKc4MJpFKJOKW4lO0WVrqMc56a3IMl/LQAU7AciKdFCIw8qmFhdoYGgwytsbhEiVecfdeQRm0s19XpT8XL17sQmFQtrJltfHCsSV4eFETDCk9mJT4cMlX8UsvZYCj322zmtg9rRA/VFjn7fEVjzaWKldICX9aBJVBlykBvhewB/1eOiuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:25 +0000
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v3 phy-next 08/24] PCI: Remove device links to PHY
Date: Mon,  9 Mar 2026 21:08:26 +0200
Message-ID: <20260309190842.927634-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0098.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::27) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3cc4e0-41c4-4e49-184d-08de7e0f6100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	RQM+Euh/xKDA8qddHm5NL+fM0OVzpt/xI6KjE9U/iaMm4KJCvqePSZri4EJkwwnUQRT1y6QtSaNVut+r6XKiHxDKVju40b6OSRmY32tXtCbYPhnYfZVUbZA9hmox4i2J2MP12RDMn4XEQvQqnhzzKybXlc2nDOCpR7VZ5k5AowjkswotwNjjajllZcMHInfBvPqMTgRBfQ2fY0t9UWdhp5CkRHxvN7W8NE48jCx4gMyfamY7qAr0Xg6bUBboLOczaakN9mqfSZ+6lSr4G8GZq/iXTbvdqOllVyWRSpJsxnPpYgZUhytw6tlxmT2s2i8dx224U7E5GkJWyB6lm9byDP0YbUehpgm2L+y95V26WATn7tmH8W0zN+CZ0CHxcxeC8pmHy0oVba7nqF5ZkO97IBNLwDegsL1Nl4qa/DQudzp4Hc+MThkwKL5tmPZq7gLDbr0AgbJKMr79ghw7yzZW/BFCBs/pE/9j1jrae/ITRDZ+jRyie57lFf/uhrTaJDHFRcjdyKtTVZolsaGHhK+mAw2CiJw12jDvmWBRiuflamyymvk73hZfqDRwjQJ15I5aok2fIaXsWNwcjcuTZQmB46ZZDDrz8sNToWVmwWtCAEIcW91DBFYWyhDYW65yM0ndePv8tUzUC9DI05Se2kK2rdon8/cYMb3hje+EKz6grZhlyFN7PachNTHdhPsj3WR/xblo+i+h8VOmqXRlS9H++DH7KZA4KarPRRHgeHxtylA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFQ2U2JrdG1IYzg4bmxET3N0anFyTkRkNzRkM0VoRGVFRDg3SGJKSFF4T0x5?=
 =?utf-8?B?UmNRRThEaFFxdFl6WW82N2gxK1l6RktHR3NFZjJURTZBeUtjSUl5cXY1Zm9W?=
 =?utf-8?B?d3VkczZFWWJtMThIaHF6UG0vdW5jS2RFdURQaGdDRGtDd0UrQTdVWmUyVVFP?=
 =?utf-8?B?UlhVam5vMmxsSytZQUVnaldENzhiRnVLTzJxbWZISVczRjN6LzcwVDY2UmJY?=
 =?utf-8?B?UFpYYSsrS2NnaFNXc0tpY2QxQktZSkwrWlRZNGg4TzY3d0RwNDhqMGo5cVJj?=
 =?utf-8?B?UElBbDBDbVRWaXVKWjZJbkF0M3E1WXViVXF5RUhRT2ViUW1kMGlkN0d0bVo5?=
 =?utf-8?B?aFJTMnN5ekM1NXg0OUJ6OWdqZTBRNE5YUk0zaE5JRVlXZTJFYlhwejlsdUhT?=
 =?utf-8?B?a1VUcVZSRHJrN2xTRzlrNnpwdlBrSitSOEhFcjhDVFBJNmpMcDJhZVUzZXZX?=
 =?utf-8?B?cUdMRW5tU3F0TVRPNUtmbmNJb1J0MzlJbE04MHc5NVBJeVZOZE5kalhHRFpx?=
 =?utf-8?B?UStyc29BaGVVSHhZdWRrZEppNmFqYndPR3VOSXJUT1dlOHYxaXB1WEZiTjRj?=
 =?utf-8?B?NlFCaGZLMUJDOWRINHM1R3l1SWx1UGpqVnBmd3VlZm9FRmhlTGVVQzVESEZY?=
 =?utf-8?B?bzc4WVRUTjk4Ri9KaEdlZnMrQkYxMW52Sml5Rkp5NTI0dmliZ1ZOQzIrV1Jj?=
 =?utf-8?B?NzI4RzZ2a0RnUGNhSnpYbHJwdUN1bVBMbjVuZ0xWSzZ2ZVRKU0R4TTN5Nlc5?=
 =?utf-8?B?dWZuZ1Q2SlNmWlh0c293bHNIdWN5bzlmbnFTZmJqQWhvWVB3bUdQc29nZDJU?=
 =?utf-8?B?aUVwNkhDeThCUVZLL3Zyakt4N0VpeE0vSDNkcXJNNVhXYVNwQU5VYTRQV3hY?=
 =?utf-8?B?akV0eGhqK1JkY2ZGR3hEUjdWNUx6VmM3cmoyajRqZXVRU0xQamFsUUxWYlFk?=
 =?utf-8?B?SFU3QVdhaEtNZjVTY2svOEFMeUg4NDVhSWVUckg1M0xNR0tZNW0rUnZXNFJo?=
 =?utf-8?B?N3NTU2ZOYk5jMDdaSE94MHA2b0w2ME1yMTlkWE9QOFpXMFR0WEtwd3paczdU?=
 =?utf-8?B?V0V0SEFyRFhMTkFGOFgwQ0hkVHFrWlp1NjVDM0xubDkrL3kvQ2ZWejY0WS9K?=
 =?utf-8?B?VTg2ZU9nTUlNcGR0K1UyU1dXQTBacnRBV1RTZ04vMkNTRFdUakpDVXdWT2Vu?=
 =?utf-8?B?dGxXbUgxNys2aXVBUXJBWmt2c1dlYmJvTnIwK1VEZ0lHYzlucEdLYnNKZlJ0?=
 =?utf-8?B?SFkzTm9ZMVpXNVFVZWljRHdET29WTERhVmtLY2Q2cGVXblhpN3lrLzhkcUQr?=
 =?utf-8?B?ZFBzcm5zbC92OTVDTkNIQnFDZTFvZmRUWHJja25HVk1PWVZWcXJzdTR4bTVh?=
 =?utf-8?B?eHlDcjErck9NNHd6OFFMMHRrUTZjY05TaG5nVWpRaDR3RTYyZFM3ZnJXSU5U?=
 =?utf-8?B?S1lLZDYwWXB5NldBZUxpcnJSQWhNZU1BTzZGNkhneElkdnNnOTBENFFLQkFY?=
 =?utf-8?B?Y3VsQTRwdTM0VnJKNituSmJjZVlUTXVZRWoyeDNONmtUUCtOajZWb1FBTE9P?=
 =?utf-8?B?Sm5YU2cyNVhzQU40WXg4N2FaMjdmcDNQR0RuM1NSS0FrUjl1ZnFaVERHYXcx?=
 =?utf-8?B?azg3ZHhCWHFmRE13NXV2YzdFVTE4UTZhZ3k5Q1M1S1dpU2QzeU5Ka0hOTlNH?=
 =?utf-8?B?MXdMdGtwZFdBUjlUeDRzL1BHSmY0ZjZaR2lBUVRHMXgxaUFoMVdTMWZOVWx5?=
 =?utf-8?B?L3BOVmZLM1p4OWd0cUhEMkdLRzI0V3k5VnI2cW9WRExQS3J2VXo4SjM4ZER3?=
 =?utf-8?B?ZWxUeXMzR1Z4Y3hEUll6YW94SVp5T29GUWpOVk9DMnA0NXFHZ0x3TXZwTGRG?=
 =?utf-8?B?cW1tUnQ3R3JTWkFwRy9lMUt5V050enBsV3FkS3lyY09uTEtQMFl0anBucEN1?=
 =?utf-8?B?aHN0cWE5YjhtbG9ITi9IcmhMK3lBVXhUbkFBVDUySllsTVVUbTJEUnpPUENI?=
 =?utf-8?B?L2hQbGdIdGJlTHhVN29tZXNTdmhxZ045bWNrUSszcWNiOTBEVGdib1FvMThv?=
 =?utf-8?B?Z0RlQm9nQzczcDJoRklsVjUwM2o4dHp1TStUSkl1ZGZrUkxYTEdmdlpHR2Zn?=
 =?utf-8?B?eWY2N05rZ1VUeGV3TmxwVFZ4NDc2QTRaOTVxTEg3SHZpOWtGeWJOUG5GOE0z?=
 =?utf-8?B?V0pkZUJDZklaS0lycEFHZXJGOFBrdEhBdGNVdGNUbHNKaFAyTjUxRmREMkNM?=
 =?utf-8?B?L1lkai9xUnJaUWVOdHBKQ1lnTG9LQ0d3UlBKOG5lc0grNmV6eWJxZlhER0tT?=
 =?utf-8?B?U3hyTmd6YmdMOHVHQ2MyaFJHNURnbmJyeUxkQlZ1Y1gwREVYWXRYNEhlV09G?=
 =?utf-8?Q?PI7ZEZXqGt6BuPtP1m1FjfLstKxRsnhiyn9g6Vmva+yf6?=
X-MS-Exchange-AntiSpam-MessageData-1: FaPqz+EoCPEwVLqgDM6piE0VzaF2ozw9MPQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3cc4e0-41c4-4e49-184d-08de7e0f6100
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:25.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATS3sS4oD/d1GXA76s+gQjUi6IVyKHzoRN2s6gAbts6F2dvjij3ytsEaH2PP59FaioT8lvdri4F+GlXt6Yl8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 0555423F5DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7037-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

This is practically a full revert of commit
7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
and a partial revert of the device link pieces from commits
dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
49229238ab47 ("PCI: keystone: Cleanup PHY handling")

The trouble with these commits is that they dereference fields inside
struct phy from a consumer driver, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link
support") from 2019, the PHY core also adds a device link to order PHY
provider and consumer suspend/resume operations. All reverted commits
are from 2017-2018, and what they do should actually be redundant now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

v2->v3:
- remove dangling set but unused phy_count local variable in
  cdns_plat_pcie_probe()
v1->v2:
- fully remove struct device link **link from struct cdns_pcie and from
  cdns_plat_pcie_probe() error path
- collect tag
- adjust commit title
---
 .../controller/cadence/pcie-cadence-plat.c    |  4 ---
 drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 --
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
 drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
 5 files changed, 5 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index b067a3296dd3..fc39c01b7964 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
-	int phy_count;
 	bool is_rc;
 	int ret;
 
@@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
-	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index a1eada56edba..0ac980249941 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	struct device_node *np = dev->of_node;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	int i;
 	int ret;
 	const char *name;
@@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
 		phy[i] = devm_phy_get(dev, name);
@@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 			ret = PTR_ERR(phy[i]);
 			goto err_phy;
 		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
 	}
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
-	pcie->link = link;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
@@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return 0;
 
 err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
+	while (--i >= 0)
 		devm_phy_put(dev, phy[i]);
-	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 443033c607d7..35b0b33bc6fb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -82,7 +82,6 @@ struct cdns_plat_pcie_of_data {
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
- * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
@@ -95,7 +94,6 @@ struct cdns_pcie {
 	bool			             is_rc;
 	int			             phy_count;
 	struct phy		             **phy;
-	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 };
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d5d26229063f..b91ab37845c9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -683,7 +682,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	int i;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	void __iomem *base;
 	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
@@ -731,10 +729,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	dra7xx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(dra7xx->clk))
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
@@ -749,12 +743,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
 			return PTR_ERR(phy[i]);
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
-		}
 	}
 
 	dra7xx->base = base;
@@ -856,10 +844,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
-err_link:
-	while (--i >= 0)
-		device_link_del(link[i]);
-
 	return ret;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 642e4c45eefc..07698c645e02 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -130,7 +130,6 @@ struct keystone_pcie {
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
-	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
@@ -1118,7 +1117,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct device_link **link;
 	struct gpio_desc *gpiod;
 	struct resource *res;
 	void __iomem *base;
@@ -1189,31 +1187,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_optional_get(dev, name);
 		if (IS_ERR(phy[i])) {
 			ret = PTR_ERR(phy[i]);
-			goto err_link;
-		}
-
-		if (!phy[i])
-			continue;
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
+			goto err;
 		}
 	}
 
 	ks_pcie->np = np;
 	ks_pcie->pci = pci;
-	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
 
@@ -1223,7 +1207,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(gpiod);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get reset GPIO\n");
-		goto err_link;
+		goto err;
 	}
 
 	/* Obtain references to the PHYs */
@@ -1238,7 +1222,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		goto err_link;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
@@ -1325,25 +1309,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
-err_link:
-	while (--i >= 0 && link[i])
-		device_link_del(link[i]);
-
+err:
 	return ret;
 }
 
 static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
-	struct device_link **link = ks_pcie->link;
-	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-	while (num_lanes--)
-		device_link_del(link[num_lanes]);
 }
 
 static struct platform_driver ks_pcie_driver = {
-- 
2.43.0


