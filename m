Return-Path: <linux-can+bounces-3381-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE70A821BF
	for <lists+linux-can@lfdr.de>; Wed,  9 Apr 2025 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B1546145A
	for <lists+linux-can@lfdr.de>; Wed,  9 Apr 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01825D903;
	Wed,  9 Apr 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="HoYkFfJI"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2103.outbound.protection.outlook.com [40.107.105.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0413CFB6;
	Wed,  9 Apr 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193396; cv=fail; b=iRPPnkR+gRVQontTTyktHfcX6BmtGiUDcpXJpaTkdPKjlYJ7gw54TFb/noy7tF3VdIZN9EE+Y4d4Mquz8Hv6ejBi3ZJueH49IecriIXbohleh5NMc5oX+ET3qVyyOlWqP7ioh7e2UCHZXj8sokqDTPmP9WFA//BaS1IUGKrgB0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193396; c=relaxed/simple;
	bh=oRHtBZ6HnE9YmLO2QsjNZIGVmngFo8Z0XIZJSzjn2CM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=YvDg80wYShosURuu5dTZsoic2X4R3sZ5Nlt7urfwHvL+LQ8H0DHEmIP0KAfXw86++uUmDBZ6CLEOPm1AgvhL+9b3/MAyJmsqeyLmD/qmqt1pDhQYDqQe+o4dc7DFtf2KXKPIsxByombyqj4GTNFmg3gEi3jjUY1WYgd3G0R0ZvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=HoYkFfJI; arc=fail smtp.client-ip=40.107.105.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1fc5KOj9zp6XmXIPm5n+6KD3v67unSF9ZK4LAHO49hhQ3djJPf0IjqhbGO0a9FvXc+N+K4MFIXk06IJTKQo2LYcE/OgeCEqN4mSogzEB6UgIy9mUDxIoZmTy/2UqaSlXCXb0ktZe3OwmJ8JG9M0nPmJ9OX2ZOw1HsmOsMBS34tIfIS+ik0fAl4FtNDDhToffuPkM8ZAMspJMU6Zn514iTMf+XH9bD+ln0u43osxmYQeMnPAvboHYr0w7iAyLA09HlLzbbfVB0wG+q0cajGZyqMONlvaNOq6Nsr8ofS1vthx2Gzvv5c92tfkpoq0X2ywnzAdVEv3X3sAcZiyJ9mNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vomhv3Sc/VU/5u3YB6qVrGrY3ZeljD4gXylEfyas1k=;
 b=aOw5GvkYyBHookuL0DiWEJJYBUivpyjqD+28tMP+0Ohvbog+ZJsKUqsEKX79Tt4tWUnXIejop565vl727qmN1iKzLt0XYGm57Xy20lE15q3rUoJe3v8yDCAb/qtIMfGxIWkv7XSRz3tpt9axEMiRtxI8vLDAkxYryVVbmKVyz+3W/l39vCcesDEx0DTaFgXArG1SCeIchAwzKnRfxNdX1AqRyV/U/+is7UO7ehOVYW7Ov6s9e3/DGb2bMqm78jYtfy6dAyqies1QYYKX6Civ+dXcSI2SCRSdGsaD+PUTukPZWiN1/5SB25KeUJ+WZ98suhremPy3/l09Dge9YqsvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vomhv3Sc/VU/5u3YB6qVrGrY3ZeljD4gXylEfyas1k=;
 b=HoYkFfJIZ8PxFqSuAJ0KRNCifJAWS3cqYzE/rtH41fkBL7JIdDgu46STzrr4tyoMlHzEQZitTCPfujf1iVgaCiPFMfoMif+Ov6pxXftZ3qwjXmEa434QLaCemz2hAMwetzOXsFlOzFMEAVytEzEf41Q6o72ho+5/nsGSCDZz1PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by DBAP193MB1130.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 10:09:49 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%6]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 10:09:49 +0000
From: Axel Forsman <axfo@kvaser.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr,
 stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 2/3] can: kvaser_pciefd: Fix echo_skb race conditions
In-Reply-To: <20250407-vanilla-lyrebird-of-leadership-5d0c72-mkl@pengutronix.de>
References: <20250331072528.137304-1-axfo@kvaser.com>
 <20250331072528.137304-3-axfo@kvaser.com>
 <20250407-vanilla-lyrebird-of-leadership-5d0c72-mkl@pengutronix.de>
Date: Wed, 09 Apr 2025 12:09:47 +0200
Message-ID: <87y0w97ij8.fsf@kvaser.com>
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007561.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f9) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|DBAP193MB1130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1963cc0a-90d2-4ff5-35ef-08dd774ea93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hPKhQ2amEiVDnQXfh8t2jA+2ZE/dtaOTUl2kB885EnZp1XXu9RX7TPlHROdF?=
 =?us-ascii?Q?xxFVwec1MtHhf+kJ3m+A68nER+gK42IusYMaEbVNKZvNYd1dKA51iQPcRPNC?=
 =?us-ascii?Q?5+rllYRKrboT6RYixozRJdDv/sU0lj0EpNyk/YGTWk2aP46DCuy+51vb1Ud6?=
 =?us-ascii?Q?q2mrNEJ//Fl9uycW0xXlFxM+sALiohZIUG6nqJuIeP/1klg14b7u7ej2sOP6?=
 =?us-ascii?Q?j8NsHOyaoumtBa8U59mxj8fJnxU5DLUErZItbd0TtUi3QTvzzsZ9EMVzl4Zk?=
 =?us-ascii?Q?azEPwPyD2lSjyv1i6l/aUztTmYYsBDD0l36HRO1spTGdZLbpg6LbWsmTF2xK?=
 =?us-ascii?Q?QpsOFJ3UPNxHF26bvZKfSgHA1m6u65bJJcIs673OB8sFb3zy9J5k2iRsXBz+?=
 =?us-ascii?Q?8SYUBCugOxfYf8uU2m8SFCe+7pEyF8uWJNHbB0OUiwCly0oo1UiPc6/+xNGJ?=
 =?us-ascii?Q?4p9GTQsZcGLOjGoiv/x1dEoHYf4x30y1dLj3r0G5GUVIPBYDqFG9T2i3gqmQ?=
 =?us-ascii?Q?5HPrI3MuDaUqX0XcsH/uqH9cY8muGcREDxffpqBeHSVpnMyaUHpk/Q4Qbj/n?=
 =?us-ascii?Q?M/jhG9ZqXQP86qxnV1Yy30vaBekwP7lD8N774h8wl3iBibDpS0nPHFpC/5Ms?=
 =?us-ascii?Q?EhYugvjN1vKbeR3LVw63iuNbmLs2VTi6cPu/usE7CsMNr+4NucpPFziIGnma?=
 =?us-ascii?Q?oahnM0Bc7kTONYvdq4UaTYO+2QjY/kTNUbPVZQaNLSYsUy/PEXrm1j8V+OgS?=
 =?us-ascii?Q?AncZZPgIjCPRPdGUJF3X9M7FHMtSO5RCwe6U/SytOPEXzHo9pzFwwrk3VKr8?=
 =?us-ascii?Q?Hu8nafVrtTEUiUu53ZFm42ZNwQals3mImpY4BuVkz7pVymWtg0YNCE7LFUA/?=
 =?us-ascii?Q?an4EzwmJCqQ+vc7PQ2JXNjukgDdZ23cBBXcR1ST+kyYXklGBRn/1P1B/iD2c?=
 =?us-ascii?Q?LR24bgZf4ybJOw2p76WL0YHBfHNLlRTofyRwsFCjjrZ0LvbuSgOysLEO2r6I?=
 =?us-ascii?Q?FFz9Nteyhp25YC1p7lU/W3rDcQcXTVyFU+V1APdbabn8+jLtyvzMNI/cSTuF?=
 =?us-ascii?Q?JSACrakc9xDbTA02iv65950FGIEjh3BTNsO6Q0bQKZ5CXrzWA5NmPPeuSD7s?=
 =?us-ascii?Q?cIw+QipvRzJlnVEaIbsTTuQFvewmEUWk/J4QBMBgX95/q9WnFz4Kaz3d8z6s?=
 =?us-ascii?Q?AoY1ckam3cGYnYACO8EjpAGj8pan8R0R42Y5FjFXKilE8uTsFWqJTDBP1S/A?=
 =?us-ascii?Q?WCuAY5mERLWGevwzPumjy9Iz0+SkN2CiSWYvZtcY7QwNeZkN/vgIP0r/StVO?=
 =?us-ascii?Q?3nwd4aGxvAJdLtY7jta6Ixl53kVpS6gPK/2JJhWwDiyOXAQj5Q2YRrAzmwlf?=
 =?us-ascii?Q?+i8v5XdgUkm+ULAtnkN2QjH8igdrD7tj9lBVWnWg438X+LDQowcs29u/Zj7m?=
 =?us-ascii?Q?YLxOUGiSPEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MFtTpCE93Akr8tb8Q9aKs4gX8b+GmEs41Q93kHy4IY/g5SfHXKzq8AZD7THg?=
 =?us-ascii?Q?H9tCiJE+iQ9F8QV9wGfhpk0KkoYoWtTEKC8aB8/38dY8SCyjqrjj8H2oc82C?=
 =?us-ascii?Q?kLkB6Ft+FkfMghnjXQkqic1r5rNr2FGC8e6ocnBGw2S+YjVsXpywloZuXkqJ?=
 =?us-ascii?Q?TndcS/+G01pnwJm7t5Mh8LbIzQvNrd0u36uioRv7RsAKutLR8YeIC/VSizJO?=
 =?us-ascii?Q?nudMVD4hpVyKIkwlhS841C6mUwTI9QlWT+4eUQ0qQRsUHpBVLoovJ7UCmChI?=
 =?us-ascii?Q?A2mxN4us1blNik0UmF6RyOOQyfHc+liawTvVtd1Gi1o0KJMDzmY6/B1Dern1?=
 =?us-ascii?Q?tRCSJNDMsRICkQyfNjMHtytgVVctBUHT8mlpWA3N1fMNcTAjothenDFBLThX?=
 =?us-ascii?Q?qph1TC4kuO8Oz7XEmfRUsnW0bmMVH0KUPBg0qoM18WYDR98RoRdP2ODtrS7l?=
 =?us-ascii?Q?VRmudmbDUh4Iw+QRICU0ceqUR8hh16JxyRhS9Gwz/U54lB0HX03EUm35FIW8?=
 =?us-ascii?Q?dfUU+XSJDSlEYjnYR7y73WgZO7gXMxjvM9H0Datj+SYJklnC/h4ZkfHM2B5M?=
 =?us-ascii?Q?iNFXgOkN0simYItymASfzLfNe+7ag8bvRQXFaVofQutOr7778QVpMt285Xu3?=
 =?us-ascii?Q?PzYJ3Yl/I84TDMWHFrTyRlMzoOHlZApshhmFWD4WuNPMJLNmfl/JDH78Z7Ed?=
 =?us-ascii?Q?kIo9Mir7bqzcPmcZ/eyC7wjNxq+3p9OU9P+mkNRz1osUvqJODJo9ceztrnHL?=
 =?us-ascii?Q?Fj+a2dLauuGEiJtC0dPxI9EUUC0yk17djmbaCirffe3V3bVE/2DkrYEoBunq?=
 =?us-ascii?Q?8SIgK/bmSAVbLW8m/sDbgFDG3YGBKEY96X4pDi/0KlluF9SsN8qeg17eOkSJ?=
 =?us-ascii?Q?i3b9MgKy4EsH7saMe/aoOKHm47QLSSTpilWT2GsdJS9+m2LYm94JOZgcWNmv?=
 =?us-ascii?Q?PFnY3tdlqDQAl4kDLQhugEvrRwpoma5VILgypm1PYL06zAa0SaRn2BgAbe+u?=
 =?us-ascii?Q?BjugJNIDSFKPImh9HvudIzozMSuINtDF0IlK2OXFDhPAv7z5P1PnPruzEAd5?=
 =?us-ascii?Q?xUYD3gWyD97tiz8W4h6pWV03dIyC6jxt1qre9sXXwAji0pbnT9j5Q3OLqccc?=
 =?us-ascii?Q?I0dmc8S4yhdpu8UZ3fibnVt0KtQ935ryLnQVI65qaJ8Txi710JG2PxyTxORw?=
 =?us-ascii?Q?+eiiZgrQVCkrBEaigDhbHhqLefv40gEGbSvVMPGF6C4GhJDTQTYqVqk2VSTo?=
 =?us-ascii?Q?A9PIPdGYGzUU4iGLNvhv75EynFmko7zKA7bcY59NQLNtvt7JWm9+kLXjLdf/?=
 =?us-ascii?Q?hDp2Gklyf1OReWmUbHZ37OX0Lo/ugd2ovNFeGoQCNAhPAcJ0+x4kM7b2GC/6?=
 =?us-ascii?Q?zOLkhJ3suxPYa1VYBnTa9dfuHXdTgkcB+uaUJ1rE9e1H5jvHwOP/C0/axqXK?=
 =?us-ascii?Q?KkFfGXLMfWud0hiIUWS24CCvMSkmH8G7eZd/MMEEDSvQgnBv9zmdvmE+3LcC?=
 =?us-ascii?Q?5nVOzptIB1B8d2X11Yj033rGmSKHmdqIwke2RdqlXplhXF5xoytwTEUVVY1B?=
 =?us-ascii?Q?7okKABiLYgVnkktExdxxB/qX3aDjItUlDU7gcnVi?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1963cc0a-90d2-4ff5-35ef-08dd774ea93a
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 10:09:49.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrFmvkbwAX1sd591vfYsgJS1sb22WaACKWXNWPsc7C6XptAwo8nG9dwPPgqwfym5VqqhlmwQcl+KN/9wqe39MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB1130

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 31.03.2025 09:25:27, Axel Forsman wrote:
>> The functions kvaser_pciefd_start_xmit() and
>> kvaser_pciefd_handle_ack_packet() raced to stop/wake TX queues and
>> get/put echo skbs, as kvaser_pciefd_can->echo_lock was only ever taken
>> when transmitting. E.g., this caused the following error:
>> 
>>     can_put_echo_skb: BUG! echo_skb 5 is occupied!
>> 
>> Instead, use the synchronization helpers in netdev_queues.h. As those
>> piggyback on BQL barriers, start updating in-flight packets and bytes
>> counts as well.
>
> This looks like it does in the right direction. Using the
> netif_subqueue_completed helpers is a great idea.
>
> What usually works even better is to have 2 counters and a mask:
> - unsigned int tx_head, tx_tail
> - TXFIFO_DEPTH
>
> The tx_head is incremented in the xmit function, tail is incremented in
> the tx_done function.
>
> There's no need to check how many buffers are free in the HW.
>
> Have a look at the rockchip-canfd driver for an example.

An attempt was made to keep this a bugfix-only commit,
but I do agree it is nicer to maintain an in-flight counter
instead of querying the device.

(A mask is inapplicable,
as the size of the device TX FIFO is not necessarily a power-of-2,
though the packets have sequence numbers so it does not matter.)

I guess a write barrier would be needed before tx_tail is incremented,
for the xmit function not to see it before __can_get_echo_skb() has
cleared the echo skb slot? (Or else, can_put_echo_skb() errors if the
slot is already non-NULL.) It is not obvious to me how rockchip-canfd
handles this?

>> +	/*
>> +	 * Without room for a new message, stop the queue until at least
>> +	 * one successful transmit.
>> +	 */
>> +	if (!netif_subqueue_maybe_stop(netdev, 0, kvaser_pciefd_tx_avail(can), 1, 1))
>> +		return NETDEV_TX_BUSY;
>
> Returning NETDEV_TX_BUSY is quite expensive, stop the queue at the end
> of this function, if the buffers are full.

Will do.

>> @@ -1638,11 +1650,25 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
>>  {
>>  	int pos = 0;
>>  	int res = 0;
>> +	unsigned int i;
>>  
>>  	do {
>>  		res = kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
>>  	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
>>  
>> +	for (i = 0; i < pcie->nr_channels; ++i) {
>> +		struct kvaser_pciefd_can *can = pcie->can[i];
>> +
>> +		if (!can->completed_tx_pkts)
>> +			continue;
>> +		netif_subqueue_completed_wake(can->can.dev, 0,
>> +					      can->completed_tx_pkts,
>> +					      can->completed_tx_bytes,
>> +					      kvaser_pciefd_tx_avail(can), 1);
>
> You can do this as soon as as one packet is finished, if you want to
> avoid too frequent wakeups, use threshold of more than 1.

I did that initially, but changed it to follow the advice of the
netdev_tx_completed_queue() docstring. Since the RX buffer for a single
IRQ may have multiple packets, would not BQL see incorrect intervals in
that case?


Thanks for the review
Axel Forsman

