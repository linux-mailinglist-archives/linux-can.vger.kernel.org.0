Return-Path: <linux-can+bounces-3718-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B565BAC6868
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 13:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B98A18940E6
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAA28315D;
	Wed, 28 May 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="R4cTvhIg"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2106.outbound.protection.outlook.com [40.107.20.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7004279794;
	Wed, 28 May 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431951; cv=fail; b=cMFa6HVgNU1m1P8e4fCVn7uJwMTA+EdYtA9vL6eY3fWTQimqgXAGLuHP4x7fd0WFXBycQcz+8uZLIIydrbzbSa8xE0DD916s6mPBQsabFA1tzy1UkgatfDmHnNoIgA76kumqm/WSoHnvccIJ1OIiVmABrrDCADcXi3pP5dzG1YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431951; c=relaxed/simple;
	bh=elx7A4rVQh4v2fQ+E5D4SemBhifLg992BlHW5OSPTnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=oxG44zE4+tbVuawyJdl5wWOGdGeRjEHVS7Quw5aeNJ4XbhfZCJ6V66i5y6UGHGATvffbPXhVOFeKzxz21z2UpytwQ/dHDhrJXCm/aEybIY3pay68HkJYa8uqnayupyiqZqKACpS87ASW731qDo4aUubVBiym4fDkv4AjOsjUfxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=R4cTvhIg; arc=fail smtp.client-ip=40.107.20.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYJXWmsNElzL3q4p2xnT0EmMQqqx+CV5sKNgc15scFo6z0cMId9N9xGL/FNruIrlD9YpLsQt2TgIDzom10AV0+7PG5r5huqLa+F84vWQzTbbGiKSWukoyDORpztIVNLmzVfDbKi5Pj+mZzOX0LWuVu7co7dOu/7vIIB8Ku9IMMeK03mPrZOrSTddFMjIuCAgWSUW6ceujb+moTx3ZDdmxVzRk//9jxJk5mBWh3Xoq3WjDhWOrBm9ZJbNmsHfXD8hydLmifks5orozTdqyjd3YZg2o2mI31aVT7q/ZSuQbS0+x9tFTKZG2GP64/Mkui0P9uR62mzS+q4gi3/nfvJoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOq+AiHZjL63omwgdRqUKwDfYUAGf5kjuQzfMvAh/eg=;
 b=KJF438PmaxMtaDo1rsy0Bu85Ysm+jAcQOTYM2OLCgqornOiEqm1rytK1NjEuBdXBkM8/Ow/aUFuOUkZxvSlZtb5bZi4/Fk1W83Yp98j/XllfO2UBf8u11HZls+m3laVzZZKgl6hTQfcNDvysPIDJOIdYqdtshzomfewNDQbBzn5gp+6tg/kRY4vhFNkW+w5H4o4EjnDhfvW/drJKJt25M8vubsT0XQVfBNcuUTGGoYy3oVv/nRo9mbESdIzYgcxPtKoraGT7K6r8gcbyRiNk1Ur3zyyFKbAURTq2euDHwyWdNCfox7gO7ST6Xpugc2F6d0rOesVw3pgSsjbrHlFYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOq+AiHZjL63omwgdRqUKwDfYUAGf5kjuQzfMvAh/eg=;
 b=R4cTvhIgbRzki350nsaYq5EpEAJnqVmATRgpUOc0oGCLOr/o64RxaMi0L6oCkj8TemCxnylDYcREvKzkIe+AyE1kR/c22COwdLam/G9ZSpMaCPYnKsZXZfo7i2Tvz1IhoO1ZwuEa8FMim+0i/DyWyhSsooHlIgqU67w5EUEdKc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by AM8P193MB1073.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 11:32:25 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 11:32:25 +0000
From: Axel Forsman <axfo@kvaser.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, Jimmy Assarsson <extja@kvaser.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: kvaser_pciefd: refine error prone echo_skb_max
 handling logic
In-Reply-To: <20250528091038.4264-1-pchelkin@ispras.ru>
References: <20250528091038.4264-1-pchelkin@ispras.ru>
Date: Wed, 28 May 2025 13:32:23 +0200
Message-ID: <87wma1nf7c.fsf@kvaser.com>
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006637.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d4) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|AM8P193MB1073:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f85903a-b556-472d-85cc-08dd9ddb51d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0gV3GECbWEgWbpGCwKW+8HsPVn7hXxq97FO6/mSAMkz9gYgV72KVLqy+r/SH?=
 =?us-ascii?Q?c12P0kO1Kh8/nv0SlFPbdljnoQtuZtJHAT5J/aOgmbz44/TWix60aZ1t+pMY?=
 =?us-ascii?Q?WHEmJG0PshO5SryiBYJhclFAJYjrxtufbEqU0pCKz5Zgg9tk/QMh8haAsRde?=
 =?us-ascii?Q?CyLMsiGdV2SeUXw8MachCAItcBSDvFtWB/hvsDNGqtGWsmhBOJKhxaO7gq73?=
 =?us-ascii?Q?qtIVBykN9qaqJQYA5hfoQ+OmSup1RtztAj5SAW4mJrqYMZAIkZWM3BLUbFl5?=
 =?us-ascii?Q?2Dsvj+baaiElkG3SP++FsnvFO3EJcBA1/ypJahBLWfEJ8Fg+ss95KGTv7UWw?=
 =?us-ascii?Q?UFm3U0mOu7BylpUUAu83hmKMUj0w/Vy7mCvTtxWIoMGwsukr1ApLZj2Ny40J?=
 =?us-ascii?Q?1wNbCUGTT/D5h5v6ohJ5XWQQkXyqNqk+MzFhpiafbdmIBjR3pvjY7DohG/D+?=
 =?us-ascii?Q?SCCEWFP8nGQYdUSRDZhSsQGddKqjHRm6W/weAfYd2Ls7VIoJQvTSsaJPDMuB?=
 =?us-ascii?Q?I0V2V20KVCOFPjFwPHWYjJImHc0hFeakh5ZkODRYzv1HnloMKWIUIGAHH19X?=
 =?us-ascii?Q?ykZlzX1Ysbo6TU730NbAc/6n/VApMlPc8ZLll/EaJTzJfwXSEyxhcmvQoZw8?=
 =?us-ascii?Q?HVZxxkc+f4j4nHRayZetExuSi6/WiOyKKxUYpk4RO2D2G/faZra/tu0O/bzu?=
 =?us-ascii?Q?F28f0AehKReiGcqN8ZghbyWphVcpwXcxOXyHyP1qRqH9RlYqQYE5UQ2KX2am?=
 =?us-ascii?Q?Vw2GvzzxBFSyylMncEz2j+K03AO9MjLB3cL5OV63BnrMJTKkAIkMBM0kbWzf?=
 =?us-ascii?Q?vt0ZeJ7dN2PXj47E46JHVJhK0P4lax28PKsNR6Tjnkz5cEAwyCLQwhYrOHxH?=
 =?us-ascii?Q?3I2d+YZxx5pBLp7QBKGp7geAEteCZWFpRTGDwwM3s3XHcLlo9RvuWgG9UQwn?=
 =?us-ascii?Q?Qsl++puiyM6mklgXyJ6msKS+BM+12ep0FxA/qkGCG7n+UbrOBXQxhm+efIas?=
 =?us-ascii?Q?eoQ7VY4k6WbKNnyBEefWKXWy6Hb5++tY1eQ6qgU82ulZHo1viOkl06zPCal2?=
 =?us-ascii?Q?H+JXMxIB1OFtR/8NnObJBktFnGIKIV1RVHoLen3AddQhBcubnrfdO7RFTbyf?=
 =?us-ascii?Q?TSgfwsVb2zFsQ4hgskt+PhI4bumc3iFcDM5UWGFqiFUjNe7ulcj01fOCuKB7?=
 =?us-ascii?Q?6HuuAbqci/VqievtLwSpY5aAtZZaV9YtKDNXYnjeERDpzC7qLGckKz2x6cm7?=
 =?us-ascii?Q?UkO8ybg7746wlVWlwEjprA1hvmq1Amah5whQrmMTOgpxZEQo32/6SGROXCEx?=
 =?us-ascii?Q?pJ+TMkn9CzgN5KV5/uC1f1MOvTOFU5XrzAo9l6vi0mqvo/JmRtuzqMB4klD0?=
 =?us-ascii?Q?nLCFK9DM40W8XE+xmQUogGzs4Gpyh5M+/ns2sXCiPmU2SzSP1jiu6go5FIP/?=
 =?us-ascii?Q?3iXCzEJD77Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsrV42X6r9DaHJiXygzdQCtFwN5qrU4rLZ8kWlZ3WHDfyaQ89jy9G28b97i0?=
 =?us-ascii?Q?jWnx4yto7DakqIrmymzx3vnzOsK1IQ2Qt18mE6ISU6/EMMpL33Tb+3ZWkRE0?=
 =?us-ascii?Q?h9WyCrEqs64JHbcMTnG9nIoyPFs42riq4zwJaVJ2v6XQstd7DpoXIANZhS2s?=
 =?us-ascii?Q?P5LRqmEkCkDDqRyfslBqY1moHjEQchY9zyS01CAXqN+5Nk87ywqDiBjpQHKg?=
 =?us-ascii?Q?C6ZyUcqSvMAC/4SJYQjCW2QzHjLFLNtKcw4BYcD/z3pGczkpUsxu/J+x8ltz?=
 =?us-ascii?Q?9FVDF+bQhqkmZQbB2JUevifXDfX12n5KWRPRbpxEdhTNC7m0ESvOVHPMatlG?=
 =?us-ascii?Q?h9wqguo/Jpgqqhz2vcrOCEqS+AXVQvblN+EStqS1bv9fJ8Ge3qalS2uOVdCn?=
 =?us-ascii?Q?qdjsb9JAcX6nn5lQhyU9Dl2TrsaPVcGlJ2bv/tKlP1F7A5gYXS86bM6aiOXa?=
 =?us-ascii?Q?iyn1nsx3kfkNKheHhcc9kyDiNgyfJ/5Wl+j9jImkKekBLM6vaj88JgA8A1Xh?=
 =?us-ascii?Q?8QFDmG+2vJ+HOebuiDwlf4J5r8Q21/tiBEwZ0uAiHnzzJ4Hie48+hr0noh/k?=
 =?us-ascii?Q?XGejWb9rpIvnqPn6/nQ3gzSYUDPTxi7abzwc1tiB9QNUM5D/NTazp87ZHysH?=
 =?us-ascii?Q?+uA9w9r9QIb9yJnbUFGgTTiTyDshh3ldGlTSQgw7lYsKtcPUyDZ7BXB2yUfz?=
 =?us-ascii?Q?dyuzNSzwk/irXvpWCUOTqMo2rxvmpDOD+3N21z6D9Op9kdd6PKPd4Do91vdW?=
 =?us-ascii?Q?VXvOdSoCTg8FnPlzaTjNpNB+6uEhgQsTE7dyAakuBUWEV/n28VligNhct3xw?=
 =?us-ascii?Q?n+/qp8KTiMLdIiucnFya6IbfrGTgXFJty6h9uITAgkU+ITaqQKHL/mHcWWOI?=
 =?us-ascii?Q?d5d0AqnQFDYfrwNK/q1l9PUG4fX5m5+5oe7lc7/5k/Mrs9DTBYQ0KgB2n+Xs?=
 =?us-ascii?Q?1Bak/4jCsUaK5hub5b/hhWlK6WpGh8kH/cdhJaekp3fEhNFkT5Yo1yqksKWY?=
 =?us-ascii?Q?W1ShPRETaiaLfosdifQqMXrJyJdT5xafeVrdP3ZUUmMaISA2WoElwjlKYzfM?=
 =?us-ascii?Q?7xKvoeZwDkOPSKVK9VAo4U/AwbbLv6JmWFAeMNJSCmnzf6XW3PP1MubdNNlR?=
 =?us-ascii?Q?klnr79Sjal8Z3bAdjuVZrCRZi45r+JOvfoZXpR+JZSf6FXJq+Kj/gtB7q4pC?=
 =?us-ascii?Q?BIpYrH2ya2rmaHL/qSaG9BdX2Jg8h6DQrvnm7Sw/h0kUtQMbBhUPxWJlhwYh?=
 =?us-ascii?Q?JCwEJePEZhoRacsRdGAdyjZb6mXoA+mSxTHgZQXaz84NfypaBWP4h1S2TAyc?=
 =?us-ascii?Q?iRmKIDADWqzg5KMdXtbXY6PiGYaBlqso3xuF3g4qW2rTVI1h37sNxU1H2BkG?=
 =?us-ascii?Q?WsHhZSjnQDDD7xcEjo0zUUxHEBW0mH4B6FyQor1oFerJEf3sQgWwMi7WzhUH?=
 =?us-ascii?Q?UbOnrZ407yjgtfqEsnKScRPRQB8qfyGQWj5xwFw/QlVDj+OEryBtXk3yLCSu?=
 =?us-ascii?Q?mvu86YfLHvRPeU66zC802uI9rVmQzCRuiJlEdsLkC69yhodYNBzjGFeZMQ3x?=
 =?us-ascii?Q?DCxbTziSUue7aJG4G9YZYiNW7mPR+4SL/LoIjRnz?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f85903a-b556-472d-85cc-08dd9ddb51d5
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:32:25.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LOhmOKScglJcbCQUkVOq1dOCEvs76/TQLt51r9iGDSjKjdEy4uZRX4RzZXVKDOwn397t7vtKFB0ziYyjMwpYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1073

Thanks for finding and fixing this bug.

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> Actually the trick with rounding up allows to calculate seq numbers
> efficiently, avoiding a more consuming 'mod' operation used in the
> current patch.

Indeed, that was the intention.

> So another approach to fix the problem would be to precompute the rounded
> up value of echo_skb_max and pass it to alloc_candev() making the size of
> the underlying echo_skb[] sufficient.

I believe that is preferable---if memory usage is a concern
KVASER_PCIEFD_CAN_TX_MAX_COUNT could be lowered by one.
Something like the following:

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index f6921368cd14..0071a51ce2c1 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -966,7 +966,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
                u32 status, tx_nr_packets_max;

                netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
-                                     KVASER_PCIEFD_CAN_TX_MAX_COUNT);
+                                     roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
                if (!netdev)
                        return -ENOMEM;

@@ -995,7 +995,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
                can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);

                can->can.clock.freq = pcie->freq;
-               can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
                spin_lock_init(&can->lock);

                can->can.bittiming_const = &kvaser_pciefd_bittiming_const;


/Axel Forsman

