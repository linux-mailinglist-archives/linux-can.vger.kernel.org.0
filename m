Return-Path: <linux-can+bounces-2524-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231439FFEF5
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AF5162CD6
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82B12DD95;
	Thu,  2 Jan 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="MAF/WwC2"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2100.outbound.protection.outlook.com [40.107.103.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DD1917ED
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844313; cv=fail; b=jkIKkX+ggQZIVdhMtWhQiREnLqTxgnkarrmJv9UTc6Yi6l2+jpdP1pmfJor4BjplXU1bGqR2snsjuw3Qt671nskydjzO0jQs2ua9mRkmsqnO67v71las6WXg/LZSlKcxoWl6WQRRprDah0Bj+nhHjM+C/36nJCvRTIFGBLtMOQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844313; c=relaxed/simple;
	bh=Prp0GOf6KbuX6lYLA4tybuF9Ko7xce6JdraipnQzay8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N0KM6q43d+lt0jhS+Ps1fLCG21eoRGOERoCmBnaOYYG+QR4FTCALNl9wDIG1euF8AnvYYhjt5zuLTXOAViX6oGLXM1O0SyGA7mJwALfUSohvSgp/TOGqzt8p512RFi6xalmCx2XpQowgQALBeXEiObt77dNChQKTitepXJ8lLT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=MAF/WwC2; arc=fail smtp.client-ip=40.107.103.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM6FCVd/V5z3XbPq77MmyUaTF88ygGy0c1NKpwjrvs4ECcwrEAtdL1Rd+wXkAHKJrz9HRcUf2NybMEb/WwCKdmo0J/Om9Su3ayHZngLw6qxPmJ7SfRl4NWGz6Z+S17orpEVMAfCQtwsxsPCSij2j1Ey70tDbtDJcrsaulvhnLfoDUtP09tS61sXMbrysUKL7sJU1kXwc8OSff/I0Gsivf6O+5OOomk8l4L5qT3Ag/5OxNdpu6RhVHsEDS5Qvj856gmVwFs+0oxx9nNvzG4FaSJzb3dtPgxhsUlAlZY7JlWDa1nfY9Ac2hbnWPb1tWcycSFp2TvKEqYKjAnJn/nfB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUkymd//p5Um0rpOAM2nJreUMW0Ashp0STiWTWAdTSs=;
 b=voMoaHwQm+di5vjYADKL4J8GHQ8lUQiGXzCCb+2ShDmZYsqW4wS3fDxF6alR7j3vqyfVRZeO9DbPOzIjbBO2tEm0cQnrhKNkahzJpacugHVLxTMWIDx5JPuZkwos0sh3K2krV3Q5i+epdKogGE/HIZteqRo+ult6eY6cGZAZ3KlRi7zCO6hdXjem1NRKp44o3jL28Z+cQaZJhq1MDuB1M+wos3onK9Gi8mmoxgjUCLdcto+2Uvx0DdOPWVfgkQeRfj2SEVfd7nhaeRVjN9Wse3LBiIVviLTERHi7lx7wIE0hfFohTMwHCIaUCxLyCOUIrQmGFvL/5qnupLAa9YrvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUkymd//p5Um0rpOAM2nJreUMW0Ashp0STiWTWAdTSs=;
 b=MAF/WwC2ispW4BSh3+J54g4wd6s/8X0qSZiHF86+68/8AF4POJpUPqYMs+Vtrc7lC1DQXfYpspVeFhYEF343TagmCa5BJ0QWiBylqBKmX0nQ9Mx9R9ncXw28rawmIqzKYO75O3vPDtm1sBCMCJU5r4wbiDwqC8vlw1hw0tFZCpo=
Received: from PA7P264CA0247.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::20)
 by PAXPR03MB7609.eurprd03.prod.outlook.com (2603:10a6:102:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:58:21 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::28) by PA7P264CA0247.outlook.office365.com
 (2603:10a6:102:371::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:21
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 6611E7C1635;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 584D02E8034; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 0/6] can: esd: add CAN-FD for esd GmbH PCIe/402 CAN interface family
Date: Thu,  2 Jan 2025 19:58:15 +0100
Message-Id: <20250102185821.670839-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|PAXPR03MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 700a0a91-4edb-4bcd-ac87-08dd2b5f6d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkxVU003WFVmem5qZmdnODhNSHN1UGxNeFRUQVJ5TC9QSEh0U1V4VjFLREZT?=
 =?utf-8?B?ek5YRkJSSjhPRXpteE5zVkNnRTY0Z3pnVTVFV2ZUUmZVMWVsS1RzM1llTTB1?=
 =?utf-8?B?NlBjYlc2c1dtU3QwQk43cW1CZXB5cnkwUW5nNTBid2oyR21OM1ZkSEZDWUF2?=
 =?utf-8?B?SnMxekpHc2pFcS93MEs5YVdMOERCY21TRGlQaks3TndaTHZNUVNOZzV2Q1ZM?=
 =?utf-8?B?WlZLbUZQRnlETWZHSDlLcHp4NkJkSkQ3M2VsVFBwMlVLMlp6dWs4Z0NLTWVC?=
 =?utf-8?B?dVh2ZXh2b2p4Nklub05Gb0ViVUhzVnZSNGFLK1d6enpqaGE4UUdDRWt5Si80?=
 =?utf-8?B?SWNXcmsxeEJLeFRZRWxiaTIzd3hGOHUvdzBGY2I4allpdnV4RGVRMWptUWlN?=
 =?utf-8?B?cFFBaXAxUFpCR3Z5elZRQzZOa2lHUEtQQS9CU0hrUWNNb2kyeTl6WmYwcHp5?=
 =?utf-8?B?eGxTaWFWekdLTk5Hd1dKWXRhTnZobEgzZEJhYzhKUnRwRVk3MUw4VVpiOVB1?=
 =?utf-8?B?ck5tQVVjaUlETWNkdHJKK3JvSCtyQ3VSNFJtUE8vc2JxNUN5elFzNll4dWZD?=
 =?utf-8?B?dlJadjNESUtsUjBhZ1g3cXRiZkxmSktHQVo2KzhhWm9CL2xmZEY5NEVoaFhZ?=
 =?utf-8?B?cTBYc3RpVGJra25hbHlVRTNha2hvWDFKOG8xQTd2R2ZSYy8vOVpnR1I4ZXZ1?=
 =?utf-8?B?OWVKdWw1cW1FTmFCMlQzUnVmTHUrdlFyNFJsaXVqa2hXSDVNVDhndEFnc3pN?=
 =?utf-8?B?eU5iZUxrOStOcVFRRm8xTTV5ZlQvSXh4Tmgyek5ZSnpXVnduWk9MdWM3WWxC?=
 =?utf-8?B?Y2R4MkdVRDV3V2tZVDNONFEzV2xTSFd4OW5nRklTb1NWcklPS3ZlN1YxTnhL?=
 =?utf-8?B?QThwYlR6dktaa3h2OU1PSWxZQ2FxV0FKZlRXR2JVYUlOMEg5NzhVZ3BBbU1h?=
 =?utf-8?B?YmVWbC9MVzROSVRSTktseXcyU3dRbHpxOXFXbnBUM1p0bTVNc3VoalU5MGlI?=
 =?utf-8?B?eHVhcGhOcTlqajNPa2VCd0gwdE5tODBERDhuekxRbjVJbm5iWlFHM1lXNmtV?=
 =?utf-8?B?NTZoMGNIL3F3T1U1ZlF3VWd3UTlRU29VT0k0SUZYWEhGdDl2dTJNaVh6MVo2?=
 =?utf-8?B?d1Ixcy9YaVEwL3QydkRNdDNWVkRSbFVGZ2hzOHFOZ0FTUnBVZXJEcDlPQzdy?=
 =?utf-8?B?M2VtSGdEUXhiWWRJUWZLSlJNVk9oWXhsVmpQR09JTjc3UUVmNUtpY1F5S09J?=
 =?utf-8?B?R1hEUi9KdFkvNTJ2OWlWUlZGdUtvOWw2RE9TNkJUdzVqWHZFUCtseWs2T2tG?=
 =?utf-8?B?bEF0cW4xTHNYb1ZZR3FhdWJrbzFaN1B5V2ZPWm1yUVk0UzhKSU5TWDc3VUh4?=
 =?utf-8?B?OFFwTTRuai9PalJJczhwZFZGZVowRUZCRVlCZy80YkFwVC9hTVFSOUl2a3dH?=
 =?utf-8?B?OWxhTEw5TktaenZweWtONWN1SCtSTjhTNm5iTlZOaHJjSWhRcGVjQmN5QkJ4?=
 =?utf-8?B?VmpxT3pGOVV1ZXd5VVRZYjQ4RzlsdzFodEIzVTVDRFZwSmd5WVl4aGdOMG9j?=
 =?utf-8?B?THNUYzBBWmsyUDRtK1poMkxaN1BBWEc3MkZGWjBzMXlYYjh3NUc3cTJIOWpt?=
 =?utf-8?B?QzJqVDZ5NXhEMmxqQlpScnloRGtuaVNsUkxoakhSTFhCc3lyeXpYVytFeWtY?=
 =?utf-8?B?QllKMVJpTnZNSENIMVRvb25QQWRkQlFVNnB0UFhXaG9sWml6QnNFZGw0M0Jt?=
 =?utf-8?B?aXdQVHUvNFYwZGxTSzFzY3ZScGcyR3ZSM2doeGxQT1VvRVM1NW1BQjBIRlBK?=
 =?utf-8?B?VStJMU9sMjVCWkVJQ3V4bzdjdzNzd1crWmtiMGNuWndYVXU5a0hxRnIyNEln?=
 =?utf-8?B?VThhYldiNU1ORXpmbzhSRjN0QzZNM2JlSEpDVXlFV2RCaFN5S3VpMkY4N3NE?=
 =?utf-8?Q?DJpjnsKXy+s=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:21.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a0a91-4edb-4bcd-ac87-08dd2b5f6d96
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7609

This patch adds support for CAN-FD in the existing esd_402_pci
driver for the PCI based PCIe/402 CAN interface family from
esd GmbH.

The patch is sent as RFC because the driver needs some
extensions in the netlink interface and user API.

@Vincent: I see that it conflicts with your changes for
   CAN-XL support in netlink.h but I send it as RFC
   to show what I have now.

The esdACC CAN controller has only a single bitrate prescaler
for both the nominal and data bitrate. The hardware was
designed this way to follow CiA recommendations for the
bitrate configuration.

The detailed recommendations of the CiA can be found here:
https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/march_2018/18-1_p28_recommendation_for_the_canfd_bit-timing_holger_zeltwanger_cia.pdf

The current bit rate calculation in the kernel is done independently
for the nominal and the data bitrate. This can lead to the fact
that the selected nominal (NBRP) and data bitrate prescalers (DBRP)
differ. This kind of configuration is not supported by the esdACC.

In a first step to avoid this I propose to add a new control mode
CAN_CTRLMODE_FD_COMMON_BRP that tells the bitrate check logic
to reject bitrate settings with different NBRP and DBRP values.

This CAN_CTRLMODE_FD_COMMON_BRP is set statically by the driver
to tell that it needs a common BRP (see patch 0005).

The netlink part of this is done in the patches marked with
"DO NOT MERGE" in this patchset. 

In a second step the bitrate calculation should be changed to
prefer to use a common BRP at least if CAN_CTRLMODE_FD_COMMON_BRP
is set. This could be based on the bitrate calculation
algorithm of my colleague Oliver Thimm that I will present
in a follow up email. This email will then also discuss the
advantages of this approach in more detail.

Unfortunately I have no patches yet.

I will send a patch set for the iproute2 tool to add the
capability to set the CAN_CTRLMODE_FD_COMMON_BRP using
"fd-common-brp" with the ip command.


Stefan Mätje (6):
  can: esd_402_pci: Add basic support for CAN-FD
  can: esd_402_pci: Add support to control TDC mode and settings
  can: esd_402_pci: Add support for esdACC CAN-FD versions below 0.72
  !!! DO NOT MERGE !!! can: netlink: add CAN_CTRLMODE_FD_COMMON_BRP user api
  can: esd_402_pci: add request to provide a common BRP
  !!! DO NOT MERGE !!! can: netlink: Reject bitrate if CAN_CTRLMODE_FD_COMMON_BRP
    is not obeyed

 drivers/net/can/dev/netlink.c          |  11 +-
 drivers/net/can/esd/esd_402_pci-core.c |  99 ++++++-
 drivers/net/can/esd/esdacc.c           | 340 +++++++++++++++++++++++--
 drivers/net/can/esd/esdacc.h           |  57 ++++-
 include/uapi/linux/can/netlink.h       |   3 +-
 5 files changed, 470 insertions(+), 40 deletions(-)


base-commit: 38f83a57aa8e644f37a88d4771d756303cfa7365
-- 
2.34.1


