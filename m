Return-Path: <linux-can+bounces-2715-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FBA25DE7
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DB53AA914
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AC2BD04;
	Mon,  3 Feb 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Cvf0E6Bv"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8238F9C;
	Mon,  3 Feb 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594697; cv=fail; b=k9jG839GrKDhfjoIRX9DWvEGYWeqWSPcPYmELB/cqu5RSyKzj57m+kRUgl7qha5iBGnFn2VT19854d9wZvNSfqHfPLhRm+QCzxWHr6Ezfcph3/wrAcv+5rdW+r7WJ/pnHsp6I/wO0i/W6s03yQJreG5jO+e5Y/X+NSUs5AULG/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594697; c=relaxed/simple;
	bh=zYpn2BInL5y+0Oq53RIBh61PMMdAqJ+AHlAbnIZw9Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fyqbvJseTCxz4FTAiiAHkuOhvTDkShaDEMpHga9UEAzj7YQ3PV7S/skpl0wq+0aWwLWVG1lPqKIN+sDyrq8OQ9ErB2afCagQRqvqPnPgkWZCFwBsyBvJ0y0YtrGe0U9Fp7cuZWNPUMd9oIfjMF2rx8D7b8R8B5YGJ6MsGhVm8DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Cvf0E6Bv; arc=fail smtp.client-ip=40.107.22.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uI3bsXwesmewtyBRIkVoQMLgY0jqc9KD7+6VrsYoplio8Tu+K71Rk8ZF8a1LKbm6OCxI5i7PrujB2QheaupZvHlZHzmyHmpKSVYI/Msp3h5jIWaAgwFdqxem+BogfQqt3HXZZqXxay5O68aESuxknMtLNvGKfDFn5kaxloIorVYALi22gUPo8LUzqJ6vR/d17HkcPRVIOjcza78leMvKR/dApb7/CCVfxhmQK+v1gbrzbgh4NXW+UQzz59NL5nMOINhg+mHs80qJrNFNmpNQggls3vINum2pZayCuJDIKWStsDdclGk/w+I0TC/OAQCqisBGYakfdGa+ek2593hW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG2+tECTGJjceFkcxQ5m8fpeKWa5CefuYQnemYAHURk=;
 b=f2j66/ZonN/7ASp+dMEzH6tW3fyXlHemcD2hXwlgykBkP/FLLHD6bQO/I2LcuhIeBqP/jLKEMbVFCASEI8DOUIY4dJ3NiJQb8hQiYGDWUAvL0Re4EkNYX3sw//lTmINpO/TRtEAW3Ng7y3NnqiCH40hheARK5o/1KAWaPbRNUR29k7UdQTPwDMn8jObxHtCLVN+LXaU2eTiZVti1Uojj9h3ba+jl395EjV8dSbfz8Jcv9p3ILg/aozQCfaxl6kTeJtvqBqnMmxlsoQzjMaqiPaBWREP0+jCv8rUSZ+Q4+h3T0E195Phm6gse6h9142bxRWvgm1vnUE9//RvOwBnSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG2+tECTGJjceFkcxQ5m8fpeKWa5CefuYQnemYAHURk=;
 b=Cvf0E6BvU4nkybDDhLQ2/KEijBYmWA7j17oXKW1XY7qveKG1CkbLhPpt4Yu5Fx2on1W/8BHI6MWf7FHQ5X67l6wX4EJfk8qy9czog3mNyF+kegkmwG/qZBZLVkGu97y+YiI6SwkPoSVDSJzBuENlbQGZYW4Rq7p3IgCgeM2FZHc=
Received: from AM0PR03CA0080.eurprd03.prod.outlook.com (2603:10a6:208:69::21)
 by PA4PR03MB7280.eurprd03.prod.outlook.com (2603:10a6:102:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 14:58:10 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:208:69:cafe::7b) by AM0PR03CA0080.outlook.office365.com
 (2603:10a6:208:69::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Mon,
 3 Feb 2025 14:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 14:58:10
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 5CB0B7C1635;
	Mon,  3 Feb 2025 15:58:10 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 4EC4E2E82C3; Mon,  3 Feb 2025 15:58:10 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 0/1] can: esd_usb: Fix device probe routine
Date: Mon,  3 Feb 2025 15:58:09 +0100
Message-Id: <20250203145810.1286331-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|PA4PR03MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 2018dabf-3b40-4d7b-0cc3-08dd44632d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWU1R2h2NjhtUzR5UkZKZmtNYnltYXJSbmVyZTlPQWlQQUNhQXdxU2orc2di?=
 =?utf-8?B?Q2hwY3ZnMS9ZZ0luYXo1REF6U2lCbG1JWEZUQTdTSEtoVC9MWDhDQTBOei9X?=
 =?utf-8?B?K2ExcXBsUllmMjRkUFYwMVp4Vm81d2JXVTBkTzFBZkptcnhBamFlS2pwcTNX?=
 =?utf-8?B?NHM1WFRMYlZTYmIvU090T1E0a1F3N21vSzJaK0ZxWFRkQ2xqNTBZNnB0N2JF?=
 =?utf-8?B?SzhZUDZsaFg1SDdDclZ5MHBOa3pOQ2d1SHBoQnNTbFgzYURPdGs2KzFFbVlk?=
 =?utf-8?B?NWV4eE15NU1qVWxQNXlUK21sQ3BEVUxwUjN2cXY5SFlUTzdselZ4UlloYzVS?=
 =?utf-8?B?dDhuQmV5NmwwOVRQeUhZbVpUaktDK3VuaElWcVFHTDVCUGhHVlJlYnlPUW5z?=
 =?utf-8?B?Rm9zQk9qN3IvYW40M202VjBiSkFNZ2RtYU5JZnhPZGZpREpldXRKM3F1STRD?=
 =?utf-8?B?SEdSK2dSc2tUNnZpQ3Nld2VlTFQ5WEduZXJxMlVaRUppbFczR1hHMmYrRFVi?=
 =?utf-8?B?S2VLSFJDNVFLK2Q2ZnlLZTB0aHRURlRmVForTGUrb2xHRDZIRm00RzFHNUhK?=
 =?utf-8?B?bFMzTndWUmUyOXBSd2FjS1Z4K1N6VGxUS3BoemFIcFpjR0Niek1iekI2VkZL?=
 =?utf-8?B?Yk51SUN6MStwVlBpMEtJKzFMM1pwYXFRY2xHdDl6SVIxRVdraVZucmRLUWhE?=
 =?utf-8?B?SG9XZnpIaUFRd3pBdUdjVXJJb2JsV2xjY3YxT2VQNVZIaE1rTEowQ0tUU2xQ?=
 =?utf-8?B?YlpXdnpvQndYZ3BxWFgvekxaczFONU15SmEyZlpKQnYyM1cxa1lIbjlxUDVh?=
 =?utf-8?B?cTZ0TlBZQVBUMWVLcEFNT0ZDUWRwOGtqWXYrRFlRd0tjQy9KbXh6VTJkVDVl?=
 =?utf-8?B?S2lxaVZWdGVUV1BVQUJKdTlXU01aY0NsOWdSZXVUSjBldU9SYU5ERmNnZ05V?=
 =?utf-8?B?TmVhOTQvQXBxSGtNeWVXRDlCZVBzbkp3ZTUxeGNTd1BLckk4anBrNDBOaFVY?=
 =?utf-8?B?bDJEUEdnL0ZTUDUvUUxDMDdseXVBbXB4blArTTJZVDUzN0hEZ05RZ3NnMUFV?=
 =?utf-8?B?YUxEVmQ1Y3laUDdmRkt1azdPaGNFMFhiTC9oM3BKbWU4b0ltR0NsNTNNTmxz?=
 =?utf-8?B?UytOeDdnYS9PejlnWGI2ckF6UTF2bGlzUFk2VEFzZUc5ZjlTUUR0bWpiZmhY?=
 =?utf-8?B?M2k2RVJZMFF4TEpmUHdTdWt0Zkl6aElHRFYxYnl5alYxTzB1eWY4aHhEOTE4?=
 =?utf-8?B?UGFPei95d3A3SmRkaHBZWGQwZUJ2b0lOMlpBYjZGc2FwK3hkbmVCbEVtdDFW?=
 =?utf-8?B?QzBnMXdnVnN0dmxBMmI3S1c2ZkhHbWZsekxIQkpHZDgvZmQ3Q2pHMTZuOFV6?=
 =?utf-8?B?MW4xRlBaOEJIKzRSQ0ljY0lHOWxRbTNNVllDT0g2VlZLRzhhTHg1WUxrNW1h?=
 =?utf-8?B?bnNrV2xwOVh6eVZVZTgrME10Uk41L3BWMmhlQmVHaWpXTDRYSk8rdHNUTGEz?=
 =?utf-8?B?NVpUVmZaakxxczhIb3NvWTYrUS9XMGthWTZTZUpDb1dSeDlXVHliVGJnRThk?=
 =?utf-8?B?TUFkdDhGeitXVGhJb21BbjBXS2QxTFl6RDkxbzN5NHhIZHFQSk4xY0d0dHFT?=
 =?utf-8?B?eVlVTVVQdnV1clBWekVCYWE2YnBQSUxaeVNKMkRZMzNIQW41Y292N2lPdEpH?=
 =?utf-8?B?aXltVGRyWU9qVXkwTXpOM2NyZ25Td0hXM1Z1OG1TeUQ4YXZBTFVtM1NGQUEv?=
 =?utf-8?B?Y1RVeG5hYnZwc09yd2FDWFJ2SlBCSWs0bmh1TGdyUXQ0L0lTZDBxdDdjeFYx?=
 =?utf-8?B?Q21CV2d4RkhtbUVHZ3N1eHN4NnBCZUJWbWJET1M0anlyeml1Vll2TWRNMTM4?=
 =?utf-8?B?TXcxdHNPUTRkTGZoc1hlT2JTbmFFVHliSFBvazRhNTcwMXYzQksvRjB5Tk5u?=
 =?utf-8?B?QnNQVEIxeFl1TVBBbjFhOE9wd3dYVmlFOFcvdTdldnpqZmR3V1FZMjhsMEh0?=
 =?utf-8?Q?4pr8mt6mMdiytZvRsfLr4onj6jdcME=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:58:10.6075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2018dabf-3b40-4d7b-0cc3-08dd44632d2d
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7280

The included patch fixes a possible failure to detect the CAN-USB/* device 
after a reboot. The patch has been published as RFC already but I didn't get
any comments. See

https://lore.kernel.org/linux-can/20241204160640.884578-1-stefan.maetje@esd.eu/


The patch carries a Fixes: tag for the commit where the support for the
CAN-USB/3-FD hit the 6.6 mainline kernel even if the erroneous code was
present in previous releases. This is done this way because with the new
hardware the problem became more visible.

Stefan Mätje (1):
  can: esd_usb: Fix not detecting version reply in probe routine

 drivers/net/can/usb/esd_usb.c | 122 +++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 30 deletions(-)


base-commit: c1a6911485b022e093c589c295a953ff744112b9
-- 
2.34.1


