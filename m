Return-Path: <linux-can+bounces-4965-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE760B9A08D
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F933BCF07
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AD2E175E;
	Wed, 24 Sep 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2okx4Eb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B602D4B69;
	Wed, 24 Sep 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720692; cv=none; b=ttV24NOTnKYokYw+bnqBulGzZ7OdlLFw0bzqyX324DCha/BiWA7xCNyKpw5VCg5sn/cL8G40x5ygIVrjdfocK/b3eOqik4g+ywIU033/RxMaQ0Twnunoz6mYeACtnfNCRXlNNWA0d8ekXl/3boCym3sgV7SXXMp3sFyX9YQuFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720692; c=relaxed/simple;
	bh=klZ7QPdc8UAVhcDWhOInEFFhMeyX6OJrzmX+G0JTJ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZbna399wAERltPHoHkyvbHA5BVZGfhaIBNFOvPImTctKm9QHDexVQz745pW5Hp6637+kHGQRCRkI+itJlXh1BKBHOjlwTBTT2thuj1LyWxCSuxPoP7xRoUAswHZEkJxcP7lZWQiCTRrTZLWk2UZQg/qN6qK/6x/KylVPe5j5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2okx4Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBE4C4CEE7;
	Wed, 24 Sep 2025 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758720691;
	bh=klZ7QPdc8UAVhcDWhOInEFFhMeyX6OJrzmX+G0JTJ5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P2okx4EbMMUqeCPPLvcLM5JyBdTFqYDIjL2yVg1vGIdJfrlPnKNwWy9YsQhao94XB
	 ghT6ACbhlO9HjLf75QN0p49hoAvzH5BaZT748Bg+BoYowR9ZKxxe8W4f6nx09+uvG3
	 QcX/XcwG9zWzOe/ALnchTqkf3DZmJc5zenpqhgjHnXy8pf+VSh6JDlkitkdzEm5Y8q
	 KZIGYkYKFT7NCzixt3FGgzKnskZSl0d4KuYSp8BVIjLIoUVCK7XA1wdq0e38NLFLfz
	 dKjEnWXeyr05hENe/VNvQDlL6CDyFE63ak9TvOhFWMHRdnW7TEFfssiJGhAjwsec3y
	 7JMWlCkecNKVQ==
Message-ID: <651d24b9-fe26-4e6f-a144-22c5997eeafb@kernel.org>
Date: Wed, 24 Sep 2025 22:31:28 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: pull-request: can-next 2025-09-24
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com,
 syzbot ci <syzbot+ci284feacb80736eb0@syzkaller.appspotmail.com>,
 biju.das.jz@bp.renesas.com, davem@davemloft.net, geert@glider.be,
 kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
 mkl@pengutronix.de, netdev@vger.kernel.org, stefan.maetje@esd.eu,
 stephane.grosjean@hms-networks.com, zhao.xichao@vivo.com
References: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
 <c952c748-4ae7-4ab9-8fd0-3e284a017273@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <c952c748-4ae7-4ab9-8fd0-3e284a017273@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2025 at 22:18, Oliver Hartkopp wrote:
> Hello Vincent,
> 
> On 24.09.25 14:40, syzbot ci wrote:
>> syzbot ci has tested the following series
>>
>> [v1] pull-request: can-next 2025-09-24
>> https://lore.kernel.org/all/20250924082104.595459-1-mkl@pengutronix.de
>> * [PATCH net-next 01/48] can: m_can: use us_to_ktime() where appropriate
>> * [PATCH net-next 02/48] MAINTAINERS: update Vincent Mailhol's email address
>> * [PATCH net-next 03/48] can: dev: sort includes by alphabetical order
>> * [PATCH net-next 04/48] can: peak: Modification of references to email
>> accounts being deleted
>> * [PATCH net-next 05/48] can: rcar_canfd: Update bit rate constants for RZ/G3E
>> and R-Car Gen4
>> * [PATCH net-next 06/48] can: rcar_canfd: Update RCANFD_CFG_* macros
>> * [PATCH net-next 07/48] can: rcar_canfd: Simplify nominal bit rate config
>> * [PATCH net-next 08/48] can: rcar_canfd: Simplify data bit rate config
>> * [PATCH net-next 09/48] can: rcar_can: Consistently use ndev for net_device
>> pointers
>> * [PATCH net-next 10/48] can: rcar_can: Add helper variable dev to
>> rcar_can_probe()
>> * [PATCH net-next 11/48] can: rcar_can: Convert to Runtime PM
>> * [PATCH net-next 12/48] can: rcar_can: Convert to BIT()
>> * [PATCH net-next 13/48] can: rcar_can: Convert to GENMASK()
>> * [PATCH net-next 14/48] can: rcar_can: CTLR bitfield conversion
>> * [PATCH net-next 15/48] can: rcar_can: TFCR bitfield conversion
>> * [PATCH net-next 16/48] can: rcar_can: BCR bitfield conversion
>> * [PATCH net-next 17/48] can: rcar_can: Mailbox bitfield conversion
>> * [PATCH net-next 18/48] can: rcar_can: Do not print alloc_candev() failures
>> * [PATCH net-next 19/48] can: rcar_can: Convert to %pe
>> * [PATCH net-next 20/48] can: esd_usb: Rework display of error messages
>> * [PATCH net-next 21/48] can: esd_usb: Avoid errors triggered from USB disconnect
>> * [PATCH net-next 22/48] can: raw: reorder struct uniqframe's members to
>> optimise packing
>> * [PATCH net-next 23/48] can: raw: use bitfields to store flags in struct
>> raw_sock
>> * [PATCH net-next 24/48] can: raw: reorder struct raw_sock's members to
>> optimise packing
>> * [PATCH net-next 25/48] can: annotate mtu accesses with READ_ONCE()
>> * [PATCH net-next 26/48] can: dev: turn can_set_static_ctrlmode() into a non-
>> inline function
>> * [PATCH net-next 27/48] can: populate the minimum and maximum MTU values
>> * [PATCH net-next 28/48] can: enable CAN XL for virtual CAN devices by default
>> * [PATCH net-next 29/48] can: dev: move struct data_bittiming_params to linux/
>> can/bittiming.h
>> * [PATCH net-next 30/48] can: dev: make can_get_relative_tdco() FD agnostic
>> and move it to bittiming.h
>> * [PATCH net-next 31/48] can: netlink: document which symbols are FD specific
>> * [PATCH net-next 32/48] can: netlink: refactor can_validate_bittiming()
>> * [PATCH net-next 33/48] can: netlink: add can_validate_tdc()
>> * [PATCH net-next 34/48] can: netlink: add can_validate_databittiming()
>> * [PATCH net-next 35/48] can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL}
>> flag reset logic
>> * [PATCH net-next 36/48] can: netlink: remove useless check in
>> can_tdc_changelink()
>> * [PATCH net-next 37/48] can: netlink: make can_tdc_changelink() FD agnostic
>> * [PATCH net-next 38/48] can: netlink: add can_dtb_changelink()
>> * [PATCH net-next 39/48] can: netlink: add can_ctrlmode_changelink()
>> * [PATCH net-next 40/48] can: netlink: make can_tdc_get_size() FD agnostic
>> * [PATCH net-next 41/48] can: netlink: add can_data_bittiming_get_size()
>> * [PATCH net-next 42/48] can: netlink: add can_bittiming_fill_info()
>> * [PATCH net-next 43/48] can: netlink: add can_bittiming_const_fill_info()
>> * [PATCH net-next 44/48] can: netlink: add can_bitrate_const_fill_info()
>> * [PATCH net-next 45/48] can: netlink: make can_tdc_fill_info() FD agnostic
>> * [PATCH net-next 46/48] can: calc_bittiming: make can_calc_tdco() FD agnostic
>> * [PATCH net-next 47/48] can: dev: add can_get_ctrlmode_str()
>> * [PATCH net-next 48/48] can: netlink: add userland error messages
>>
>> and found the following issue:
>> KASAN: slab-out-of-bounds Read in can_setup
>>
>> Full report is available here:
>> https://ci.syzbot.org/series/7feff13b-7247-438c-9d92-b8e9fda977c7
>>
>> ***
>>
>> KASAN: slab-out-of-bounds Read in can_setup
>>
>> tree:      net-next
>> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/
>> net-next.git
>> base:      315f423be0d1ebe720d8fd4fa6bed68586b13d34
>> arch:      amd64
>> compiler:  Debian clang version 20.1.8 (+
>> +20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> config:    https://ci.syzbot.org/builds/08331a39-4a31-4f96-a377-3125df2af883/
>> config
>> C repro:   https://ci.syzbot.org/findings/46cae752-cb54-4ceb-87cb-
>> bb9d2fdb1d79/c_repro
>> syz repro: https://ci.syzbot.org/findings/46cae752-cb54-4ceb-87cb-
>> bb9d2fdb1d79/syz_repro
>>
>> netlink: 24 bytes leftover after parsing attributes in process `syz.0.17'.
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in can_set_default_mtu drivers/net/can/dev/
>> dev.c:350 [inline]
>> BUG: KASAN: slab-out-of-bounds in can_setup+0x209/0x280 drivers/net/can/dev/
>> dev.c:279
>> Read of size 4 at addr ffff888106a6ee74 by task syz.0.17/5999
>>
>> CPU: 1 UID: 0 PID: 5999 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-
>> debian-1.16.2-1 04/01/2014
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:378 [inline]
>>   print_report+0xca/0x240 mm/kasan/report.c:482
>>   kasan_report+0x118/0x150 mm/kasan/report.c:595
>>   can_set_default_mtu drivers/net/can/dev/dev.c:350 [inline]
> 
> When can_set_default_mtu() is called from the netlink config context it is also
> used for virtual CAN interfaces (which was created by syzbot here), where the
> priv pointer is not valid.

Ack. I am pretty sure that I tested it on the virtual interfaces, but I did not
have KASAN activated. So I did not notice the problem.

> Please use
> 
> struct can_priv *priv = safe_candev_priv(dev);
> 
> to detect virtual CAN interfaces too.

Exactly! I am reaching the same conclusion.

Right now, I am testing this patch:

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index e5a82aa77958..1a309ae4850d 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -345,9 +345,9 @@ EXPORT_SYMBOL_GPL(free_candev);

 void can_set_default_mtu(struct net_device *dev)
 {
-       struct can_priv *priv = netdev_priv(dev);
+       struct can_priv *priv = safe_candev_priv(dev);

-       if (priv->ctrlmode & CAN_CTRLMODE_FD) {
+       if (priv && (priv->ctrlmode & CAN_CTRLMODE_FD)) {
                dev->mtu = CANFD_MTU;
                dev->min_mtu = CANFD_MTU;
                dev->max_mtu = CANFD_MTU;

It is compiling rigth now. Another potential fix could also be:

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index e5a82aa77958..66c7a9eee7dd 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -273,11 +273,12 @@ void can_setup(struct net_device *dev)
 {
        dev->type = ARPHRD_CAN;
        dev->hard_header_len = 0;
+       dev->mtu = CAN_MTU;
+       dev->min_mtu = CAN_MTU;
+       dev->max_mtu = CAN_MTU;
        dev->addr_len = 0;
        dev->tx_queue_len = 10;

-       can_set_default_mtu(dev);
-
        /* New-style flags. */
        dev->flags = IFF_NOARP;
        dev->features = NETIF_F_HW_CSUM;


@Marc, once I finish testing, can I just send you a diff patch and ask to squash
it in:

  [PATCH net-next 27/48] can: populate the minimum and maximum MTU values

?


Yours sincerely,
Vincent Mailhol


