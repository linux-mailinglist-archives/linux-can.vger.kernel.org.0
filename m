Return-Path: <linux-can+bounces-7034-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I/CGD8br2lOOAIAu9opvQ
	(envelope-from <linux-can+bounces-7034-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:10:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174223F458
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B51F8301BA5A
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CF36896D;
	Mon,  9 Mar 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TnhuHxDv"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01A3603FA;
	Mon,  9 Mar 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083378; cv=fail; b=qV69DDI7VAo6rtpYuxFgIxdpb09wvbMZsAtrpiKqjgYRnuY+PS8DMynz3lOcVG7Y5kTSebAQDaOMFHCW6YMCogyG4QD9vyINBgRuRnVt8qG2AIlh4uXH8lt7ywN+7FljmxAIjUrJwycnkmnH5FlfoJge7nRSgdI7hEbY+jmuNfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083378; c=relaxed/simple;
	bh=WueqfUgkKw3v+rPOIf1un1C6j6Q7QKBK+G9Rb45uWA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcIGNNG1NLwjYHyYYXT1A1QYHViEeY6tHupt/thRLaJ3OLnMvF5W1YLcizmxEthdbIl3ZLShcTDxJsDM58IV0NspzIts6nopQUvIKu40OpUi7Tx5W2ujBK6O2BjWd15crqyac3LZcneIn+ZvI5IqbTNxegGm6OC/+KlUxsGWSDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TnhuHxDv; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy4RKBUA+icMH0wA4X+ptGpkV3sWEAPiCzsgMB0AR5TnQ3/YqpVTNvYWY1/i6dDgUrqC0sBadeIvZl0BGC8THoHYJfBMy8mobQ47s7wi4RhQYzJibRj0Js75R8Tyb/vq1sA6gRFUJstJcGSQ3O6ypNoBecypLdvna8NRayj5tcF9M7VkVjcDlpLOjqUhLL9pZwZbw3unK2xZkpCZFICSEEUYtSTAsXBVW7Gl2rlttsGJ0pcQMk5YYc08CJRW/syxGK7Rr/AZSralG1YR4IpZQcK5HWJm8+wi5vbvgC5rg8qfdbpCJ1KAHdMZqQyKB9xGEHoQku7wikSDQlFaDk1hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCO+4CqHJAz7zGjj0gSYC03MYTuBYOlW1IUHdEwMCZU=;
 b=Nou5L4cCVLBpwyyyYnaNOUMFY/eWjrffbt+F05ToTpdP834wd6hivkcId2fYgP61p818sOq9+12cJwN68cHm+IwbCyC5pEL8rq1qwD9sp95ODeXgBqsbG2DvVYG/AoBm+tPk9QNyBqPYgggRrt1kAcbKIVS5aSkw+ESEsLYG5CNOUisHteEDr2ujyBE+7oONmIUYDRiJjPaBaPIra//4v+HAjf78DYA7bV32sSx5jiQIhfD5iI0R77h3k/8j5PQ/bFzE/ed6NWZbLYFzV9J8ftV3HR7m5agkj22RRZh4eRL2ASO1QQ9Q9V4ZpqVKyih4HZ5SPoWj2gxW5UCNbnkxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCO+4CqHJAz7zGjj0gSYC03MYTuBYOlW1IUHdEwMCZU=;
 b=TnhuHxDvuQP/DU1YZkm9MLkH+wC7ZsMIKC5uiuGyB7DgRD+cQRImE2FVO/qcCyl/n/poQbmCGq+6FYn8TXhreYt40ZSrffh0YgRLhED/frQ0aPBzQ51TC0Rl1GD3uJiEsE2STjxRYGg2Jy4/VrJRnWKVM0EyPQugvAnnupuMTtugsc+1FO4wyFC1qEASsPW4ViAqm6D1irpiSxNnpfH06R6Qv9xBDd+NlNAJTwUI3DdwXacNxw40v+LE7MUmFxEcblXwiyo+X0iO66gLkodvDpTWCJqglTuFnPZV3Y5HmfVLtd46nSxHEEPfkwE0vw+6QEARszyV9fx/VVgEpPC6jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:18 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:18 +0000
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 phy-next 05/24] phy: add <linux/pm_runtime.h> where missing
Date: Mon,  9 Mar 2026 21:08:23 +0200
Message-ID: <20260309190842.927634-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd53822-4158-4e92-4ee7-08de7e0f5cfc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 LENOre81CuXAIjhOndax+kALN0X0ERZaPsQTivs1QOq8OWTeJKDIAdHXnyzpXQpeKDv9nB+MZOPdnsiYBZ9P76UN+9dH/I/5s4rZbZnYSnV4vQOkx9yzNW5mJEK7652+X8L0ZGCcNK6zGCH6VmFiSQyjmjOs2pbWgTshlzoWFwLMwLIgrNUTuLNkGXzf6cca/v0yt4hlSAK4cgRtJN65szxiXVFMkYP8zk/1UpLHlLk+tDEPlw+noPrldV3X4BEJqNQTRukqZVfJCDQEIqK5L1AkiM82ze5J5O62vQambVs6FrqurNUXE4TrY1oRhnH6hs8yXXG8Vb8DqXhMp79jTM8Z5ANj4EpvvxdxrHtB8UsMMMsrD/0MLVPsjApuUAUv1OOLVkzjWlCnB8zWgIba48mrnf0wwrn/pihSaKUAYefV+DCWWO3R0DLl7nVpBT2B2HDAq14NHDi1xaq9Fo2cvVQ/jK6gqd/OwZDr3cMkrSIw5/UrRprj4opO5+TnBsKXAeiSDD6JwZK/m/VDj/B5jdRglbDQJ4rPBoZoijpOkxJo7NYcfJdNqvYoU/LKJet3RPYkj0v9fDkr3uHvKnRtmZx4pA5Gv4FW/2TjKJzcqWMfGaZb7cTreLBcZFkkS77Vup1Gbdlso4oohYS0vo/oTq3RUJoKEpWg7DU9btmI3r9oEP0ZvdhiIFhxv9CaCucq3MwytvYqtpIlCpNs+rGc9w1bYFyljiJ+VKCfCmX+G7o=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WjJKVmxMVzhLME5TdlV6bmtpVXNaUUtmbWZnOHdxL1dDR0g4SDVwcDhrY25V?=
 =?utf-8?B?dG03dkhpcUxMNTlHSGVVajV3N2xPamIxblc4YzBQU1U4SFBZTGRhM0NDS3Yx?=
 =?utf-8?B?aGpzcUNtZzBYemJKTUdEMUc3bldlVXVKcG9mVHJhWHRyeVJvbTJKUUFWeVRx?=
 =?utf-8?B?dERnb3dXaFJrQjgvZStNVU9ZMWZleW9oaHpnY1ViYjJVTE56dU9NY2t0MGxR?=
 =?utf-8?B?anhpL2s3QlQ2am9JaFNMWVJ0MjM5MzE2aVZkUm9OK3FNWnVMUzZtTExNTjdo?=
 =?utf-8?B?WVBjUE1iTXlHU0c5bWNZV05xSEYxZVNhU01CZUJveWhUa0xCV0dac0lUU3kz?=
 =?utf-8?B?ZXExVnVsQ1VrcU10RnpqUnJPVDE1YXZybTUvVGlCQU43aHA2bXZ1bC9wWVMy?=
 =?utf-8?B?VlZNckJzaTYxRlVTT0lHaEM1bUNEZDgvSzUwbHJObjlPWmhRNzdyZThkVUxu?=
 =?utf-8?B?dDd6QzlnMVZvZnFjMERTR3QyS0hjMWpqZUNHZFR6dnRJU1BYNlhJRlhHUHY3?=
 =?utf-8?B?VnhNVzZSM3BYUVlkbmJVc205NWd3VmFtUzhTSmdRTzdMRVZLbXc4bmVhQXY4?=
 =?utf-8?B?V0RwREFLanAvSFNMbGpTcVpKVUZEMDV4dUo5UWVYSm4vZkc0bVJ2RHgyUWlm?=
 =?utf-8?B?V2VCNC9pc2tmRVVwVzdPOXByTFlaa1ZuSEpiT09HcldSK3hZZGJBU09tQUQ5?=
 =?utf-8?B?c3BUVkZ0QWR6RUc2aFlqektEYVpIK2Y1UmhwVm1pNXR3cS9DOUxEMlpiNlc0?=
 =?utf-8?B?WTFiZWVMajVHR2puam5rWGxIVW1hWmc1d3lmSDluQkpXVkZmUFNhVnI0ZU9G?=
 =?utf-8?B?Z3dNdU41SHJldHNodlZOSXdKVi9yanJPMlZwYkNJYzJyeVVTQmNVdWErbitw?=
 =?utf-8?B?ajB2UHNkTFN5SVpJZEZzaENON2MzQnAyL1NqSFJxUlVUSG5UbkIzbjBtNXRs?=
 =?utf-8?B?QnMvdDFUa0ppMi9ZK0Q1T3lLajdEeEE0WDlXM241QU9jNXdaUXZKOEpqNW9V?=
 =?utf-8?B?akV5ejBhS3JZdWdvRTJrenpFcHBQc2FXRXZrczJwUWk0UkE4NEwwYjJSUDBu?=
 =?utf-8?B?TWlSZGlCYWFKOEppZWFXaVAxNHdwTU5qLy8wWXRhT3lkbjZOZDlydkxlN2p0?=
 =?utf-8?B?VEUzY2NSMHk3dlJCb2QyaFFrblJja2RhMEhTSzc0cG9RQzVWOUovVkVHYkd6?=
 =?utf-8?B?TWRJaHFmKzhxaXdMaU8yT1JTSUthaUFtZ1RXeWlVeHVubStTMy9qWnM2cDZs?=
 =?utf-8?B?NnhTZ2RDblZuVDRXRk5iL1ZjUy9FYlhvL1UyM2pJNU9BZE9MSnp0cEhxaHBR?=
 =?utf-8?B?WUtPeTRzemtYeGM0SElSMEM1VlFUZHRxVDVLMDRXRUVjaG5leW5PbGk3N1lS?=
 =?utf-8?B?aEpPY3ZVa0E0US9vYVEzR0I0RmNXSEoyN2tvLzJqNGJISktOR2N2K2FEUTVS?=
 =?utf-8?B?aUlwVEFuelNQVzJQS2Vya25QS3NBTnlHczJvSFJYaExRN0ZuK3c2bFRMbDhJ?=
 =?utf-8?B?VU1PM0k2ZUpYS1B1aUVuSmdYeUZ1STFvV1NtTU96YTN2Q0lPUU1acjR5WmI2?=
 =?utf-8?B?Q0wzV25WQ05LYkljT2pOOHozb1hna3hyWkNSUEhmN1gxRDlvcHFXM0YvdDZE?=
 =?utf-8?B?d0MzUlhYZFNZUEwvR3dCSWpQbnhDanNlV20vYlQvdHN2OEE5RHFPTVEzV1Y4?=
 =?utf-8?B?N3BCT3FLcUNkU2RsV0lPb1NYYy9JdjcvaGx2K20weEU3V2U2MlM0MUZxS2hB?=
 =?utf-8?B?WVk4M1pzeW1ZT0VMcklkaXlKRW5QNWs2a05sZURzbnpJdXd6ZmtJa0Y0VFlY?=
 =?utf-8?B?Q0FFTU5PQW9NbXhEVm5ZM3BKd2t4RFRJcSt4L3EzdDVPemk5dnQ4dTk0SkdG?=
 =?utf-8?B?TkZDWVdmS0NLcW9xTVk1M3NRNUlqdFhqWGlhaWZJRDJnUTQvRGNJTURhbEY0?=
 =?utf-8?B?Wk90ek13aDlWemV4UDhKTXhzcGV5amQ1RnVYWjJwK1RSUHpKb0lrTUd0OTdD?=
 =?utf-8?B?NWNZeDVuV0h3WVZhS1B3T0xSSEJxUytFdUJYcWpZWGFDZ3J5bmpKcVNlQU5a?=
 =?utf-8?B?dSsybzgwb2NuNTFpWVNKc3hDZ2tXaGhZRks0MEdmUTZBSEVyVjl4dlc5cDNH?=
 =?utf-8?B?dU0vSG9RdUwyS0MxeWR4WEYyYVpzYWpUdTc1UitRNFd3NEZuWGs2SGErNUFt?=
 =?utf-8?B?MmFLaUVCUUNiUk1RRHo5SGNveGFiNDhsenZmRFhwTEZlRzdHU2x1bVFqdWEr?=
 =?utf-8?B?NmRWYnNFRTFKQjI3a2dENEVyM2lXM25PbEFaR2NQcVJtU1pFeFdtdFk0UE11?=
 =?utf-8?B?U2hSSytjVWZoOGtXOGl2VlM0djdING9sZFBwOGxpUGExaSt0bGZKTkVnZFJp?=
 =?utf-8?Q?Phfv544JTgsqVtbxKJJnCZeimlVX8QvUHi0BeB1YvRI2U?=
X-MS-Exchange-AntiSpam-MessageData-1: sCuTfhND5AaGvQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd53822-4158-4e92-4ee7-08de7e0f5cfc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:18.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+aUneH98kVAp8p7h7WzwvLlBxJ0DJRw4jehsIOQVQqmLif1/ljbZ9sKUpv+RC5ZTMuvTJzBUgvBlmqvps1xFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 2174223F458
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7034-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,glider.be,gmail.com,sntech.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sntech.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,glider.be:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
call runtime PM operations without including the proper header.

This was provided by <linux/phy/phy.h> but no function exported by this
header directly needs it. So we need to drop it from there, and fix up
drivers that used to depend on that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: André Draszik <andre.draszik@linaro.org> # google
---
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>

v2->v3: none
v1->v2: collect tags
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c    | 1 +
 drivers/phy/phy-google-usb.c                   | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c          | 1 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c  | 1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
 drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +
 drivers/phy/rockchip/phy-rockchip-typec.c      | 1 +
 drivers/phy/ti/phy-tusb1210.c                  | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index fd0e0cd1c1cf..ce1dad8c438d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index ab20bc20f19e..48cfa2e28347 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 93f1aa10d400..b9ea7d058e93 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490c..2bd5862c5ba8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index b0ecd5ba2464..d88b8a415e85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index c342479a3798..f62e1f6ecc07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..191040f6d60f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..8915fa250e81 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-pcie.c b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
index c0e5a4ac82de..3e2cf59ad480 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-pcie.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define PHY_CTRL		0x4000		/* R8A77980 only */
diff --git a/drivers/phy/renesas/r8a779f0-ether-serdes.c b/drivers/phy/renesas/r8a779f0-ether-serdes.c
index 8a6b6f366fe3..c34427ac4fdb 100644
--- a/drivers/phy/renesas/r8a779f0-ether-serdes.c
+++ b/drivers/phy/renesas/r8a779f0-ether-serdes.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #define R8A779F0_ETH_SERDES_NUM			3
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d9701b6106d5..0a318ccf1bbf 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -49,6 +49,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index c3ae9d7948d7..b7080403e649 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -13,6 +13,7 @@
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.43.0


