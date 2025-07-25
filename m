Return-Path: <linux-can+bounces-4136-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADDCB11EB2
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1845435C4
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62662EBDE8;
	Fri, 25 Jul 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="SKlBOaN4"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BE2EBBB0;
	Fri, 25 Jul 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446908; cv=fail; b=hWZPk13NiF2Y/J+MNG+/+wKYbEHbBRnnfckN4CQoX0G10jrAumaWcHmPPNnHnig9rcEZubwOdxY/S2bWbdMNhZbbuFVJ9oDs0Gq8Rv1GgSAEsXWR/a2cKZyjq8GTcz9sd/FsOcVFHSPZi7kEp5NQbJu6GL8ngbkiQupSeOoOq1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446908; c=relaxed/simple;
	bh=UhTzAQQxNsphG5977E6iyzKQpmaJ27hMyLNZ1h1uWt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UW0Pt9KqvgM4Rsw/IJ/LEz4m7nFMyr60SMCDzcajH/t53CjOwg2X3KcjzOXnEtMspB/ynvAKVCErEdAUT6ItTNf+u2OQnCHk7V0k2/h5VtKs3n4mjSmtB3oGkQSuIQ3IGpamtp6YzYHpgE2tQwYHcGkh6h7fmrhOdXUC8bOsV/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=SKlBOaN4; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzoWM0vlEc0RDA0wWXV0DCxC6P3+aZe1xc+IWscaSF4t94tYIvQFxtX20PbCIEV55NGEYRF9j6gVGaHQYHS6CsMGKipo2QQlwGXXPgP7U6ie9VKQT57erhWf+YoQ5jvNTGTr03UyrjmVoKptDatCTH8+wYDW1g5ZU4cdr9w/HENY2b2bxHdMHshqAkss5EAm7HW+8qQQl6BiEKk/BREQQaUrUujomb80626Ds790iaKkAGRbMpShaxMIe/VfO0OqsjhwvEpCw/OPBnizn1UDjW/k+O5YoVMYwwvYcrGV87rvzzy1vkVc3R/oouF2BkbS7ApyAaziEeQYYT7efbeaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWoFOdXq0BQagQW/453hbA6MO5Kfkvx9ThsSxq4MGO4=;
 b=H1ucb0rgtCvYai+6wCcBYHHDYy1l9lB/INLcaSjVQYsiysKKnd37NQ3gBJfP3GDXmcdB5QwG+7JTIPz+ck1nMbGSQB2BD7GuGjDyGB45B7vH6GXe0iCsFE8PyyLrchGK4JVm/snpgUajHOxZ90NOKxy4F2AFwzMBp3MGTFdXR4fZ+SIRlcR9IsEnHBv7k1NnfeNp0n02/7MSU5hdbvUbAwVcp9dN7EfMU/nYq4a4tZCLkeBotAbZlk1/2fFFpWFQhKOL2YZjZJXt/Y9t2QsB0tgY5dEIuNrcsUNHIwV8BMolNmchhNjoTRDSM9BzXxzjCDDmMXpaupSPipmTeyfpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWoFOdXq0BQagQW/453hbA6MO5Kfkvx9ThsSxq4MGO4=;
 b=SKlBOaN439J2/3XCZyw3ijVK3HyNXn+aO2CwJ8TAnIyHbp/hSHm1I+6z/JlLIyaus4ZULpE2nPkyQgCCJTRKOc5OO8gDGs9WzZ1ZM1rzXrVMe5nRlv3wxP1B/Eoxv8/1BpQAqx0Ivz8gvlfnGcPAS8aMZjWiqGCerjD9Y+/7W6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:02 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:02 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 03/11] can: kvaser_usb: Assign netdev.dev_port based on device channel index
Date: Fri, 25 Jul 2025 14:34:44 +0200
Message-ID: <20250725123452.41-4-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: c8035c5a-2f9b-407d-d4f1-08ddcb77ad5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8n9/nEwiaDxC9WFUwzoCS+Ek5i3exH+ZkrXfARiJ9KP5o/XEKy7AwTcGZrE/?=
 =?us-ascii?Q?MkoIfQVsPrGH/DiFOj41/nMUZD0Z9otX7zxK0HRcHeXwkuzCF3lp7Goz41Bz?=
 =?us-ascii?Q?n9F38qHD6NVeZIahdFTNosWqW/O2L3dS28EDkkH0H9StgQajECOVnOTZJbZS?=
 =?us-ascii?Q?jNMYWEp2DrB+jrO1fz+UuPIx3URaeFflwbHjBbTkWy08/cky5L6ripjYOZBm?=
 =?us-ascii?Q?Du+FtTvS52sfgk7LH/Nai60aBLGx8UEn8Ut8zQ5ppWc/WRPWQ5Kx6UIsdjPy?=
 =?us-ascii?Q?WsFPEQYeLOrs5WFHEgD7bY2UdLBNQE2YkOjnFklXQWpXI4F4I6wRMQUbIKG+?=
 =?us-ascii?Q?fjKADBW6DvOUIlocRqHT7dfS96AGVU2GO/XKSkwxokQ93CsVJNdydiYWhBVW?=
 =?us-ascii?Q?KoyE/5XeL/2cxZw4iDX+77yhfpWQyCmGnNbXDiO7YFSFiXmYLyGfm0iBZmfn?=
 =?us-ascii?Q?0Ga8mOcJEKCtRf+6JhYOnvOuSwlFRsdNxOnV0wwxkPwa0azlp+7nvyd/RKgJ?=
 =?us-ascii?Q?U9dGXePqQTbN4t7lpHD846ygt6vKpMdA0PtVVtZw/VuGWFilXTfxIHiyGcIg?=
 =?us-ascii?Q?ocFC8zXeFDXuWBFRNtjZRnU7n8DMOdyF6o9GgCQeUnZQtnZ8nVYs5gksBtYm?=
 =?us-ascii?Q?jvgv1vD7iJgR/LG4ntleDC3Fk7bHdLIPGAE3K8OW/0gEOGdTOmroH1uXUUxO?=
 =?us-ascii?Q?3UDmbhb96BCRgsxtZNO2pK76mwlPCIaTpENNA/i/LRU5oBzfGvVY+SeBK9X4?=
 =?us-ascii?Q?pbediHtDvK2/GEyYLAy+nwyaYkQoGYxsixrpMF9++QobKFFPNXwQYo9Bkyf5?=
 =?us-ascii?Q?sqiILYVN5mYmz3jAqUtz55GKp63bIXCCYPud9E0+XZqcZ6sC8w2aI9WjZ1JN?=
 =?us-ascii?Q?S7m9wWDVzTzZy9jkOyNU/ay2cj73a8mdp0oArZ4s/Uybf3LkHUJP9YfMRjQ3?=
 =?us-ascii?Q?0LQ4d168J/PEfMCIe50jRa9hWaFatqaGSUJEbouvRRZvAEr5oTHvF1Jc0fXz?=
 =?us-ascii?Q?JOCnHbgLTAoXgVUpt2hm40LIXWZvJuV8iyl2JrRcXyBNvh1M+a7S1tOyIe5b?=
 =?us-ascii?Q?hPVyeEgY1VeWQ27nNOkHYY2SHOoKYHew7xxpoGL0H8z3LF1lqZYR8wDaaWxu?=
 =?us-ascii?Q?MdDad/kKaLLUYMjRDXXJ/dqyr54J3PHEj8DJvEL/CXpFJi21jNobIb9alUyM?=
 =?us-ascii?Q?1yVlaCRoZsgC1GYFX8HCNvBIZ2zpwSsgNL6kP8yhr3BpEIpmdYUfgvypLye4?=
 =?us-ascii?Q?KIzjrumP+IZ2vqO0NmVTV3VhxX/oihJe7ZKsQWpst+p5lRxnyK9+LwEgGouk?=
 =?us-ascii?Q?XrMztUt2X3+E9JLwXqUPsnOU8jZGwM8uNHI99xCEEvgv8WScDKD1IfS0RITW?=
 =?us-ascii?Q?4+z8GGCiv7m/KPZBuqvolFDBMPTjP5oLOPFt+eSHpRFCGvP+6uF53zp/41UO?=
 =?us-ascii?Q?2UWan5kPiag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jM2fPJWFpXGbNHwKF+GCa6Y4VDWBMIX3b9oOLNPgnIH/eUA6rUGBZE41zBkm?=
 =?us-ascii?Q?naH/InpnZIqwS+Ecvk1DkUwmVhUzzN8SoiIkOLwtutt5jcYZoG19U4rCFXQ8?=
 =?us-ascii?Q?24IsRA+gRp8lJdzEqfOa16XwWjZixbNttlqhH04k4P1SgTC1ncsfy7X1vuP4?=
 =?us-ascii?Q?ZQAWujtwlkELnpQ5p0UsRAAMfQ3ToC/wzKGFHYW2Zis3TMwBEY5/nC4FsRLh?=
 =?us-ascii?Q?5CeY4GrFmp8Mbys6WS5Qfm7ibiug5+U7JGtvZqnpyawQLTk3a+GoZ7v3R7HO?=
 =?us-ascii?Q?46iOduCrvs8fGxcv1pPmeULxUHYndSnNIpTAEaDaitg8Flv5ZsUizPEWWXqR?=
 =?us-ascii?Q?01UEu8Dsp2wckfKCGLGfvbXnkEaS3INBWqzWVLZ49WJKQQKJofXcInEwpeSp?=
 =?us-ascii?Q?x9+PiYFNwaXHe5oqJ6oCikIU/voiV4DS/KI0mPLkrevio90/XtBAYFVRwMSB?=
 =?us-ascii?Q?PS1AqHJ517mdO4rQ/Nb8TsIlN5nDoevQ3wwmoJ6dXQKoudCpvb0Mlsqhb0xE?=
 =?us-ascii?Q?M5SVP3tKt+U5E6tgwqbrI/OeENJlmutk+NnYBgDl/LhU2RPrwHqVLacTvw0U?=
 =?us-ascii?Q?U3HLgsFZ8mNR0N/wlxcHm+WIS/wHCR2K3qG9kOsTlOUxqro+ZG3xBVw/ZULv?=
 =?us-ascii?Q?BqHY/rfBefpsuwzQR3YmI+HU/tGDQusunqEhouuPqAOUFVfbOq8nems3bIyS?=
 =?us-ascii?Q?FF/bSPoqzDSjGW5w+EebZbJ3H5dv7FWPxxsLgFyqiHqDpGywPM6JX7VfWD9k?=
 =?us-ascii?Q?WFh27/kGQOYjMW/r3wvlCiLmfh2h1YuGB95VgXnNCDcL5OO0l0TLOdNyCown?=
 =?us-ascii?Q?n1SD+fVfWHBDCFDoG/ccrrolF7GwIXPaexfUVYaviolTDarIDo7InUUx9QwZ?=
 =?us-ascii?Q?RceH8f4+9mQs2CUbNvZbxfHR0HVcHWP3la+nSsHqBpVIoMJep4gn5aOHfaMC?=
 =?us-ascii?Q?L+6rfFYeohwbZaKXfdIZsnMNxvG4i5tJ0GU5tHbjorCHT+qf+WITrwVVm4X+?=
 =?us-ascii?Q?oPRuVbYqnoTUaY3fYRizBtE4WKo1cjBgV6+bqftB4NvjDBJAMX1yA91tqJT6?=
 =?us-ascii?Q?d52LqZc4CIgTMbLKlvQrhgQRWQnQX38Nofj5uZWsXOBuX0wopdAVQsv4sOOS?=
 =?us-ascii?Q?7L3WsQUsPPices9EmdvXBdetJDEYWxPv+79AgwtJFG9RXVMNb6woL82EMpGo?=
 =?us-ascii?Q?rwZw/fmEoa7jxTdvC+JaVSys7mybfJ64tajXbIuPKAMBUTBPCGuHmEc8g2bQ?=
 =?us-ascii?Q?dkb1W+P4c31/gASEcEheTuXT2f3wxJVBKjb5lZ/oJFxViSYKAjN52SkmYh6k?=
 =?us-ascii?Q?273QRgyw4f5+u4e7f57PQqUZvsMxXDDdPqJHv341I0gB1t1YnKnw5+VHhITj?=
 =?us-ascii?Q?3xjSmNnC6lfwx7a+NZyGIsiOArAcf24K5Orr6R7THiDlR3GRFqOCiWE/d8i8?=
 =?us-ascii?Q?DMmChhndpcajmksdIxUeriV6alu8CZq05dVXcilmdg78SmUfoe6T+2W81HyQ?=
 =?us-ascii?Q?/4AWy3d1i/2G+QMZ0WGHZjOsNtFlcV/SHZ/i3jKrur+cEitZNKE9zmQ2HRkX?=
 =?us-ascii?Q?DMmltKo69NlFSiN8N1jMKuVFoZu5nGoKyWtIbvH/Q9k0sHrnvcDlTp2AhugQ?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8035c5a-2f9b-407d-d4f1-08ddcb77ad5c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:02.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxTzJV6xGap5aATDzFAexDcsbcg11RtfZYTP694rodDumw5OMmxvims1+09s1GV/4Eh7egAEJveIxJjUrl3iWrlqJZAnICmcGqRINPp8oxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Assign netdev.dev_port based on the device channel index, to indicate the
port number of the network device.
While this driver already uses netdev.dev_id for that purpose, dev_port is
more appropriate. However, retain dev_id to avoid potential regressions.

Fixes: 3e66d0138c05 ("can: populate netdev::dev_id for udev discrimination")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index c74875f978c4..7be8604bf760 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -878,6 +878,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	dev->nets[channel] = priv;
 
-- 
2.49.0


