Return-Path: <linux-can+bounces-986-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE193440E
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDB3282A76
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6B188CB1;
	Wed, 17 Jul 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="AJDXwqS0"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020116.outbound.protection.outlook.com [52.101.69.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD421822FD;
	Wed, 17 Jul 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252657; cv=fail; b=nvgfl0n7mV7liNLNfOPPAMMxBMeqNPplk0Q51VLeNHrIZefAufOo2gK0pH8G9k0Xt4aKBXKSLPk8gZpKYlvXc7Y1qcrx00Vp+iwlUgpby58sZIHhYbceRqVZ5nG5aDM9036vLUy9MZAxr2fJ5HVj301bz4Eqnw/DdfaPP3Pl9a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252657; c=relaxed/simple;
	bh=ceqHBvgFTTVoja0GTY7EDYCXDxhPJ6u4UUVub3Sw3Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i9rJMIFgYmSsEwjzt9l5Km1IY3V3R8LMyfu0JeJUB/E9UTrBkQK06owqAxTd4ndA3YYQ7WI5taamvI2tkOXMdELnPcT+xruwJsBqzwQS5ah4dII0TQSebNo4kRI5Y1WMO/OYzaLo8hD911MbnOATBwp+lTV4pLl1T3R0p2Y8s9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=AJDXwqS0; arc=fail smtp.client-ip=52.101.69.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gThYnNHaJwCb4IOtev3ZUCe9eCmfaYAPnKW5aybsSSkgTvvogA0/thRF0KbcMHwwDhQXu3pX/R5M1X1At4HUDOEdb+yFxuhArjusXGdW5Qaw2d92IMZvFk9932HNX8Wk33sGLhX3awOe0LfTY2NYYUi4lCA+xOKEGsbfC0+4W+h6wMhFR66u0LkSPLTImCd//BrwGmwOq0YyR+Fj3mCxATem7WiQyrxotSktppnrWCfDAptem4o3yAkixM2qScOOyDpcHIQhiQveK5XlA4Rer90ovhKj8X/Q1tLuypvIAvbblWVOeVrH1z+GZG8GSLlnlHWMiAflITr7c1Ps157ujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fhRy3kzIVOPN5Yn/l85kLNce7Ucr6tPCMQP+nU1VoE=;
 b=OftNLudHVJgxBFGmoQenkVJURgCVkNKRwUQt9joDaJEdAnNOCfQL61ZvFTW7kNyWo4zYiHuRX+t7jkA1i4/ShgELRenH9cB8WBd9qW1k/+816k87m1F1lqAdIqibw0xO8jTAwIt7PvYTnDF2qEScS4Zl/bYPYgYo9A7lIuxs38Nl2C635MvtHknxmGIBGD7iQeYSObupnVoni5RzKrXcfNlvJ/bLS7aNJKH7kUCMcbNz/cK4jvpV/SkoJbec5jTnmgL2CpqeWMVns0UsOqIdgSN883FQmtYsNkbn0ca51WHEbX7hALYhCDRdA7UToCzLZuj1XnBYz4cRq03fni6rBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fhRy3kzIVOPN5Yn/l85kLNce7Ucr6tPCMQP+nU1VoE=;
 b=AJDXwqS0vtLtJaz28hDgFICjJluPKmhbwMTLfVMsVuScu/fAJLxTZrgl0Kgi1drAE4W4YS0VnvciJdP5qhI4ovwOic9HGljr87nn3GX0lNcbvLZcno+eNqqxxHDT+1aRJdyqq5hmSo2i3caa3ff1jGBH2wd3wVj1jT4IkXT1Wgk=
Received: from AM6PR02CA0034.eurprd02.prod.outlook.com (2603:10a6:20b:6e::47)
 by GV1PR03MB10385.eurprd03.prod.outlook.com (2603:10a6:150:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Wed, 17 Jul
 2024 21:44:10 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:20b:6e:cafe::8c) by AM6PR02CA0034.outlook.office365.com
 (2603:10a6:20b:6e::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Wed, 17 Jul 2024 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server id 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024
 21:44:09 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 883F87C16C8;
	Wed, 17 Jul 2024 23:44:09 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 764072E014B; Wed, 17 Jul 2024 23:44:09 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/2] can: esd_402_pci: Do cleanup; Add one-shot mode
Date: Wed, 17 Jul 2024 23:44:07 +0200
Message-Id: <20240717214409.3934333-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|GV1PR03MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 97864543-2fdb-4c64-476c-08dca6a99760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVhBeGRKZnpEYmdiQW5jS0RnSGphRFVvUTE2K21mS2FRTXVzek1TQU43MG45?=
 =?utf-8?B?WDI5S3ptbkxmZi8zRkNSVVdjc09ob3NoVUxZUDhvNE5lTGdiUVQvdEsxaHlo?=
 =?utf-8?B?NUpKYTRGeFo1bTA1TkpUUWl0T3JkSjRGOW9zWXgrZUxJb1BaOW5HWGRqeVQ4?=
 =?utf-8?B?eWRrRUllMlgzdzN0ZExGNGx4NFJTd0hzUzA4bGZqWVhZVkdYZjhtMHNvK0hF?=
 =?utf-8?B?a1ZJT1lXeFFaaGNwV1owZEQ3eDQvUzlNdXBaUjhDTys1aFl2K0hyN3RCQzZ0?=
 =?utf-8?B?NEVxZTkzTWkxTFZSVDd4RjVTMkZQMWVZWUNKMm03bFB4Sk9WQW8zYWFnWWNI?=
 =?utf-8?B?dzN3MHM1VFR5eHZacWloN01YWDlIaytIRUlPOWQyZnZneWpHMDJ1SU9jdEpq?=
 =?utf-8?B?ZXJWbUhGcWdmZUI3WVN0UHduMTNZQWthdjVOV3BPeDlRV0kvOEsxUUM4Y2lx?=
 =?utf-8?B?cmNMSkZobWRTVitmTXJOTzQwekZpVFZ1TjJLWUZSVmZJMHI1ei9YWmUvK2FG?=
 =?utf-8?B?dEJHYWZBaU1qVXZ1elZDUjhKVW13ekl0MlRLb1dUbGJESUhDYy9uUjNoTnFr?=
 =?utf-8?B?SjQwM3lsZmJEaDF2MUtBYTR3ak1nUVJ6MG5iSWNIeGRmNHVnV0k2b01sVmsx?=
 =?utf-8?B?bjN4ZHl5YmdsZ0lHSXUzYkdlRkhkbFZIRTlNWnFiMHhuUjIwV28za2hrTzE2?=
 =?utf-8?B?ajF6ZXFVWU4wNk92ajhlWXhNY2RZYVlGSzFMamtoMUVTL3FQeU93VExXTWZ3?=
 =?utf-8?B?b3ZJZnJPQ0tMZXRBSnNDeTk2T1lmL054OXZmb3lyT250THJYQkdzZVVlSGg5?=
 =?utf-8?B?NjJnSjF1bzRncFZDQVhjQUcyZk9samdGZnNYcHQ0YXVhTHZ2ditzOVpZZ1pr?=
 =?utf-8?B?bVduMGMyM0t6TFEycnJIQThPdlprT1MrZDlsd0p6NGxHTXc5eG5STURvYXQz?=
 =?utf-8?B?cERSVmU0d0lJOHlySG16YTBlbmpuZUIyQXhJdGdWRzRzaWhFRGhJVS9KRDVk?=
 =?utf-8?B?aG9LV1hFYzc5Znc2U1RLZnUyWDNjL2hYQXdja01UM1JockhUYzFHRGd6MnY4?=
 =?utf-8?B?bFZrb2tGU0IrdFp0ek84MWZWcyt5bXJKSGFFNTNOZDJCU0MzaDRrak14VWhx?=
 =?utf-8?B?RUVKYy9GbVpyaG9RTm5PNnViL2tHb1NMY21YRVVMenhWeFBoS0hHQ05iN2JT?=
 =?utf-8?B?OUdQcTZQZ0duSkNzYldxaFFVa0xwclROb2xFR3drZlc0VXNPWEpjQ3VndndH?=
 =?utf-8?B?NXVycVhCeERGVVVSc0I3UjZaRTNYT2YwbHVUU0xBbDNOQzg1V0xaNGRmNk5X?=
 =?utf-8?B?cW1jRXdDZFRqWjdjQ0pzc1p4ajFLY1BxU2x6RHg5bnpKaldZcEszNE1XVHEy?=
 =?utf-8?B?M0FUVzdEMDRoZjh6NVRrRUVLOWZwN0FET3V4VWd2a05KUE9mczJLWWhWeUxq?=
 =?utf-8?B?eHNNRGNVN01OU2dDalNkMWdJM2o5VVIvbXAyMnlnaCtYSDBYbkFxQXhybVRR?=
 =?utf-8?B?UUk0MkNaekN1dk9zSzdjaWcrS0N2VkQ4WFNNSUw0cUUva2tGamlkNjNsRDJH?=
 =?utf-8?B?ZUh0UjJKNXh1N3JPSnEzdFdhejdIbGV3Q1l1dlV4UDhCRHhPSGpZdWQyTEt4?=
 =?utf-8?B?akZtMXRrOHQ0ZUVJbUJLRWVHZkJabGJTL3R4RUNheWxSbVplU2ZUQTNOS0Fr?=
 =?utf-8?B?ZEdMWkFtSlEwY3pwVUxqZWVEa0ptcVYrVVo3QlA1a2VOZk1hYlpoWE9NTDJ2?=
 =?utf-8?B?OFBQeGx6TStBZTdpb2NCa09QQVNrNnp4d0xJUys4dTI5anExS1VwQThzcXBr?=
 =?utf-8?B?TzJHQkIxbjRqRU1oQmppMENpUFgveUNidm5uMTYvbnE4cE1lREhxQlN3bU9q?=
 =?utf-8?B?eldaS0ZabXptbkxUaExUVDRwTjV1eTVJNmFYNG96emFDbUx4YnM2ME1jN0JH?=
 =?utf-8?Q?HinEQBuBQJ/N4wDo17Kv/sgZ8nQQW4y/?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:44:09.8495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97864543-2fdb-4c64-476c-08dca6a99760
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10385

The goal of this patch series is to do some cleanup
and also add the support for the one-shot mode before
the next patch introduces CAN-FD support for this
driver.

Stefan Mätje (2):
  can: esd_402_pci: Rename esdACC CTRL register macros
  can: esd_402_pci: Add support for one-shot mode

 drivers/net/can/esd/esd_402_pci-core.c |  5 ++-
 drivers/net/can/esd/esdacc.c           | 55 ++++++++++++++------------
 drivers/net/can/esd/esdacc.h           | 38 +++++++++---------
 3 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.34.1


