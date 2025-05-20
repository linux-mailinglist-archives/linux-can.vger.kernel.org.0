Return-Path: <linux-can+bounces-3598-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6CABD723
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B22189AA46
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4127B50C;
	Tue, 20 May 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="c/mau3nb"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2102.outbound.protection.outlook.com [40.107.249.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601C27CB2C;
	Tue, 20 May 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741435; cv=fail; b=HKzFliOJUO91PWgWcDgsvxRzdeD+VxqmxvAQRjmNgvm+ZWY0UzDJ30cMCZKLlofPBNBCit2jk8oQyErVlflNaJK/bQkYTr3nN90ndMQ1d3YiQie91gpoXCQ+HQj3gaXe+wIcfsPHGn2TvJlJbfGmxZ7xJY6pzIdAQLFsaUhw/zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741435; c=relaxed/simple;
	bh=GRBAWB2gzwsOxxlArdji7nOgSA38uo0wt2BcDsXujyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHo95gHG7nhTJ1T7P2OSX4+KGGHXGWYcbsr5/odhFYlGh+juY/9RaoX3r6vK1SjoZmBUNHnv9zkP/A6iCOhLKkvIXKgbqLR26GFdhK7lzwMtI6G/qSRLk4Fh+qs0zLPW5zapSPrtQLztOCxAlCNYdx/E3ueB4BjWVzEwgevvRLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=c/mau3nb; arc=fail smtp.client-ip=40.107.249.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykb0dlX/2bOpVHex1Nwr5Sxxw1pRpBViyHApGe+q1ZcKXCLh9tffY5RPAPUEpwmISVj7+6UbBAdNV/4Yh3J1XqxyPHuxZLJNyxxMskwTC2l0Yf56JeTc8MBwtT6rCDod2uFLgvan1VpIAp2Q2iIByAqeXpkqX0KWvNS1JbT3ofkyNSYOIgJhZp8MzJIVWttUJpbCIlMnvaQH1P++wlA2sV66d1GWjoV8G9SPiW38+USRAETWtyK420rD/5Ot8wdsyov2V/MqnAH6P6Hk/1QOsbvnGZlasNb8ukmEYs06wB4DT5PRUVsgg40XOpEZESba3Wz13KT7b3ioIxJhAqgAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nUEn5MLzpd7PINy0V+AnnjcEHUU8bNy3vJd0FtbeqI=;
 b=Sjeiqx2jy4s+v8/kRf93wRgqwBXQ7+6Iq7QFMbUci1kizjvxH9uxaS8NmgATVWHEx9yZwuJ5iVSySavLR0zOJvi84yvuXCacu7KiNERtzQwOCMKm83gNe/NUGRwCH4lc7c1VkTMXSXXJFoNOReE1UtZM0ud19QvUogG8meGqyj/UqdvMxGZzh4viEC5S/Z7b6qFebesPHLYpxkevS/Hwt8AJ88+2mX2lL/ThUzgepLF6xYVfVsPQn3bv1NlRFPDG6+8RxJH6obcJbGPhF7wP8yp0zl7jtrbGW9+Rcpy0bv/XCNn9WyJSj7LBU95n0d4CRAYK46By8wutc601yDVPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nUEn5MLzpd7PINy0V+AnnjcEHUU8bNy3vJd0FtbeqI=;
 b=c/mau3nbvuyL5HwUZY23/4CKewPlTuxgg5EHpDpQ4dq4Hnom0xylfIJ7DQBEx1xQ9F/YdSS27CWz4H8OAEsauCweLY8Tl+PzfEYDe5cfBbw5Z7rYHjTzZyBwjNREuNSeA6/tQ1K5q2pt7jQVeVOmuGABve7aWmHhcVSB7wEZyy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by DU2P193MB2226.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 20 May
 2025 11:43:47 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:43:47 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 3/3] can: kvaser_pciefd: Continue parsing DMA buf after dropped RX
Date: Tue, 20 May 2025 13:43:32 +0200
Message-ID: <20250520114332.8961-4-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520114332.8961-1-axfo@kvaser.com>
References: <20250520114332.8961-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|DU2P193MB2226:EE_
X-MS-Office365-Filtering-Correlation-Id: 34689059-be53-43fe-2ebc-08dd979394e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OcaP9+o3MR++4N0V02lwLrACC23uwFd3Um+1nEPAoDAbRidKxvGYWvQlHvd2?=
 =?us-ascii?Q?wAQK0c8gWoTFstxEKfiF6L7NLn6e6H2nMXLV2OsGh+ZAEFP27OkP3kLJKyVi?=
 =?us-ascii?Q?wtTcPtauzW15555RD7UCNTtKXADZThsZBiynahMEZNRobdz7a4lZOLYHHAhD?=
 =?us-ascii?Q?2h6sDM9LPtfwJ3T4eWw21OrkGlLGZ1H8BepxoHQew4u9qOxn89lYq1gBWQTU?=
 =?us-ascii?Q?vPQIZNl3XgOpQL2yKSKCAB57Z869jba6Pypvod/oA/8nODK5ZwBd33eaww95?=
 =?us-ascii?Q?cs+fw1Q8d//U02SVSdZPsQ1q3VAs7QD/1XLqXTn3+yzwiJ3dstweEFtWewP2?=
 =?us-ascii?Q?GhSfCUJzLGrAItwv+CZ4/F1PSIwUofIZUK2XMlnlHT0Z69uk/XUW1nDBcVI2?=
 =?us-ascii?Q?LhOgkKFudiVumDTHuLvE8Vun8rF2aWcOM0cCuVJodVZt/foBe2BkVZLhnOsw?=
 =?us-ascii?Q?b6BSnRBcrpucoBnR5w5Src8VvW3lzlia4lfr6P6fnSdcpbrVxrI72hGNMvus?=
 =?us-ascii?Q?mrIChv9yYxD8mNRMkbQ/f1UrkPTDRxmGMme54rplAu8alXySkcFYSYQd9rxc?=
 =?us-ascii?Q?VevMSQFBxTLnhfZOGJEtSflKdwtskl4+ErYcGARi0fr97cnQ4LeNYjr8fI8/?=
 =?us-ascii?Q?QcAlxJckloPXsMkQPJospCuaOl2zxY/BM0D8gW304c1Csg361SyrG9QvKJPv?=
 =?us-ascii?Q?Q508herRVTIQKM3t1s+fqn6s8S6TvZlZeFIt9RVpKszTvRuRfTUWEPxJaZr9?=
 =?us-ascii?Q?61IEdMRXqglbuRqA0o33Hr6yKAYxutoPIFYa5P6jir/sgUFj7CZtSrU8G8aR?=
 =?us-ascii?Q?W0eehmF1+MmYR2AUao1ONIg0LlzoX+cPrlaC3TOT1qGi08Yu3cpwdxYWvASE?=
 =?us-ascii?Q?vl0zFEfEIKzVsmRvoYNRHB2uEGt9hR1felzzGPFbIRO7GDZ6Yi6TEY3RzBPP?=
 =?us-ascii?Q?S2DxQSW56It8ipiO8IasVuYEtTnYf087RlvK4txAMDlHMHQklZqr2SmMyO00?=
 =?us-ascii?Q?6Mhpacc7hFJU0dtH0CmPbFdVcH2QDYXQTYL79oaflMBdJ0ReVoZYrLkEReot?=
 =?us-ascii?Q?bRBJeSwhhmavphy1OnfFLszYrvwAinYTRj6OLHStzID0FVkCNhKTKjPATS0F?=
 =?us-ascii?Q?eJ8dJBfBJ3zcG4pJXB7xaY5X4tF8MUKJXG+8goAqNeor6Csep3b0wMsnAvOq?=
 =?us-ascii?Q?lxjMBr5bfv0KlmTmyaHF2zX6YU6uO+Tgcq2FEETP2xWsmuIymG1zKW3v66wK?=
 =?us-ascii?Q?plMFUEgcRjKsFSu7Tp8Cnr0/jaq4QRlfITMGX/FitpUpjDXnIU1sprozWuig?=
 =?us-ascii?Q?nNBZ/BY+Nby4q9ceW7OMh0sPEHqn25+OBfCV0KctsfkWtMHVkQOcqSBaggEQ?=
 =?us-ascii?Q?Bcw5OafFQXwCVhP2TDHravIXc+clf5PeNarhUdDUdfmqXFqLBmUysgJ/DPEn?=
 =?us-ascii?Q?ZuvzLYPu3D0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgRfzt+Phq2T4WU4ydokxgAn5MrQVfcQbgH+tKbF+zf93fMzAgw6uZ5VSjH8?=
 =?us-ascii?Q?MnOnfEqomIyVVVq1SMLbenKwyvutZgMwBNifTtH18TFkev8U9sX932+twWc+?=
 =?us-ascii?Q?ooIb8GR4pyV5jfh+RZvVmlbngSZk4Cii4HFSned1706K7TQ6fuwM2f93xZAB?=
 =?us-ascii?Q?Q07Evv6KpkgZWPOXWqFE3vIs1yJdvVesb5k6UAaijsie4YnNLu4GCzIWEUWZ?=
 =?us-ascii?Q?oxw4Ls4Z7yUyz0HALMolIUCZwNysBjKkPKlc7yP4kzxZDwbBU7sOAT0yF8JK?=
 =?us-ascii?Q?/4HSotdzdzr/UvYhiqeQXKxK8DYfMK8W/HQ/UB52UvR8rUn7viYPmRXaj9Jp?=
 =?us-ascii?Q?Dk5NWMu083wEtak1gXRIl3VRwXymTGL584jqudpCSeRV5ZrdTIHzoa0An6yz?=
 =?us-ascii?Q?A3lAkOj3c7DIHEUoCjqm9DSbJyRPKQx2nN5MiD0pyV8WZFevij20rtc77rtX?=
 =?us-ascii?Q?NmoF1FC3klzRrY8l2sAym8gNwRXUK3WLv7Wl5TiDFHB7hv9cxQEaklynSaOI?=
 =?us-ascii?Q?2I8PjjCDLRGms5578mic1MmBg21VgYlYoZp8TxBx+YEsHfwt487UL54Xwdn+?=
 =?us-ascii?Q?U7NZcul6Abu/F5mVWRfEep+JLVzXV3O5B8JR834uwBBJ+esXyHzMDWlVYLb0?=
 =?us-ascii?Q?SWrrg7FAvS3y4K3nQ+jW8n5u7fZ8RL9hHgbQWHaz7sP513ercIV7ht1fugkE?=
 =?us-ascii?Q?dShQ236VMpjuADyJDqEfeWXV2pNsi4cb09XZ94aViVsC1P3ot8ISUsUj22qz?=
 =?us-ascii?Q?uKOqDqKLprWVzx9XbPz3nyBN1jt0nZG6iwU37rUd3K3mYxsEhOdWvRFoNR3e?=
 =?us-ascii?Q?Z4S1r80oQx1nJBWkMHF8B5qiCtegYtAHuGaDSI3S4tvSLfcSWD3T8xvuS+bO?=
 =?us-ascii?Q?3AgRYV4F2e2D4sBIdIMmPofmviPM7QMrrRvt0cXEchkPO2eym3r21s2FHwGT?=
 =?us-ascii?Q?oFP21rnwP9fWwYqkQOeENrI0qkS5jAQgwmHSImUDVW/EyKSMck9HW7T1qH2A?=
 =?us-ascii?Q?Ba+vOoGBVF64cM9zcDN4d20q5EMVyBpHEdNX5rFLSEcEJ7ck1Ym+9UvZv6K2?=
 =?us-ascii?Q?z6xH+Sjw1dpc76Ol7ejR0uMhWswj1Xqi8xTsADhC1qZcDBP5GsJ6+Chmae5S?=
 =?us-ascii?Q?JxXehTY+Of/N7/oLSFEfa/OZ8/JbjnNKSyEO378UF0kruq0JCPTFDtoBhxRg?=
 =?us-ascii?Q?Nu+HYStbewCvBRN27eQtBF3UQf1uSa+qWWS7WzVeAPlBDqHeJtUAqZFOmLGF?=
 =?us-ascii?Q?by8D0OqZ0hpxUm/VYMMVmMetUYwmcyaack9QtmB0QaldBNP4qkFARkkIC/Tn?=
 =?us-ascii?Q?QG+Mh4ElidEQFn2yup0U0eARH8ZYw0wXDhLAYYkZM2x9s+NGAE8WDdfJDZWv?=
 =?us-ascii?Q?0+Pw8A1V+B4vKUZBDKQTSpW7IDaA/y6Jd96JZl1IYbGMLe0VKdRWcP3EwEH/?=
 =?us-ascii?Q?0wfWSjnRp3Imqz+lf1Elx0SfIm38gqeh2EHiZECC5jFgLDzq2M3vdgjOXroZ?=
 =?us-ascii?Q?JNJfVVHn8Mj0fZQm1wrcCz/XU8RiIBQuBjhvF7+H55l4eEN+nTOCJyo9m2Ai?=
 =?us-ascii?Q?sMFLhHt+YEylfcsIVXt9RdnwGygeM5UhH5D9MgLz?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34689059-be53-43fe-2ebc-08dd979394e0
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:43:47.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci7P3l00cN/FyAncz9KcA2maBAtWCFJ1W6dJoGxQVtT07qwxQrYzbZqVH3n42gyNeCKbkqOvixJfiITBSgqn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2226

Going bus-off on a channel doing RX could result in dropped packets.

As netif_running() gets cleared before the channel abort procedure,
the handling of any last RDATA packets would see netif_rx() return
non-zero to signal a dropped packet. kvaser_pciefd_read_buffer() dealt
with this "error" by breaking out of processing the remaining DMA RX
buffer.

Only return an error from kvaser_pciefd_read_buffer() due to packet
corruption, otherwise handle it internally.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a61cbade96d9..f6921368cd14 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1209,7 +1209,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_canfd_skb(priv->dev, &cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 
 		cf->len = can_fd_dlc2len(dlc);
@@ -1221,7 +1221,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
@@ -1239,7 +1239,9 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	priv->dev->stats.rx_packets++;
 	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
-	return netif_rx(skb);
+	netif_rx(skb);
+
+	return 0;
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
-- 
2.47.2


