Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62251781ECF
	for <lists+linux-can@lfdr.de>; Sun, 20 Aug 2023 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHTQKu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 20 Aug 2023 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHTQKt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 20 Aug 2023 12:10:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A864208;
        Sun, 20 Aug 2023 09:08:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1CBC95C00CC;
        Sun, 20 Aug 2023 12:08:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 20 Aug 2023 12:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692547699; x=1692634099; bh=BxzZ+9NJUrzNh
        ki5lVNYAAEL7wZfwcHLqKEFYyFd67g=; b=ArXDzhOaajpJz7sTJsp08Gfgcm9Ya
        G9hTfk34jR5/XaoP0fm3bZFjmSUSNwnKc8VVJb9OgG68HwDnT5F/0O7ZacSLA5V1
        UmDTX9t9e6QHi2lerh7IgpD4LUa4gJqa0duOzOyPG90dMeO2ZtwPBah1QAxLoChK
        bZyhqrNQv8tIPJrPPneNoOKj7fJpFfgLRnt9zEYBJaIcGNLhGN5rlJ+wOeXD8O8a
        kE1JCoZxR+JdA2uvOVhRQ15hKfeckff8Wss5uI24BwZhNDv0L1jdZmXIDjap82yx
        iO23Ej435mhWvJjgFdfyWl5hyOftIP9AMjtnb+JzUwU6yCRfUx4ZW+fcA==
X-ME-Sender: <xms:cjriZKKcYEsF3K0ufFNYJgfmdGDT2GOKoHU7WEyHhQtrmY5m3TVugA>
    <xme:cjriZCJZKg5IXCxVt8heXlIO9Qr5AvSd8M0PtLi7WThIEI3XvLg74EzUtH3_3JY1W
    CfFOYbBFvgmTi8>
X-ME-Received: <xmr:cjriZKvX1LImLGNoPALVQXEgbBf-hg9JiSkE4GezA1BWnAJM_wWl-ZD-dcpO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddujedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehi
    ughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnhepveeggeeugfduueduueevleeggf
    ejfedtleegfffgjeejudduffefffdttdehtdetnecuffhomhgrihhnpehshiiikhgrlhhl
    vghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:cjriZPbh6r4zu272K5cwPOMEXJ17oOO1otswR7tT8A5M22MJSZNOyQ>
    <xmx:cjriZBb-EDBQpQzaxUWrHIYHP-YtzsgAPnpAtf3ifxDi__Gk0lzk4w>
    <xmx:cjriZLCPsox_tsKkoJmM41l3j5tHa2daAL188wVSJ1JsLRbnecFwhg>
    <xmx:czriZORBq0hlwPHbHSM5AuhztSLdxRkqWnrma-XvDvTx2PLdCrpjtw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Aug 2023 12:08:17 -0400 (EDT)
Date:   Sun, 20 Aug 2023 19:08:13 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        wg@grandegger.com, mkl@pengutronix.de, idosch@nvidia.com,
        lucien.xin@gmail.com, xemul@parallels.com, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
Message-ID: <ZOI6bf86B1fVb1sF@shredder>
References: <20230819012602.239550-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819012602.239550-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Aug 18, 2023 at 06:26:02PM -0700, Jakub Kicinski wrote:
> veth and vxcan need to make sure the ifindexes of the peer
> are not negative, core does not validate this.
> 
> Using iproute2 with user-space-level checking removed:
> 
> Before:
> 
>   # ./ip link add index 10 type veth peer index -1
>   # ip link show
>   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>   2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>     link/ether 52:54:00:74:b2:03 brd ff:ff:ff:ff:ff:ff
>   10: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 8a:90:ff:57:6d:5d brd ff:ff:ff:ff:ff:ff
>   -1: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether ae:ed:18:e6:fa:7f brd ff:ff:ff:ff:ff:ff
> 
> Now:
> 
>   $ ./ip link add index 10 type veth peer index -1
>   Error: ifindex can't be negative.
> 
> This problem surfaced in net-next because an explicit WARN()
> was added, the root cause is older.
> 
> Fixes: e6f8f1a739b6 ("veth: Allow to create peer link with given ifindex")
> Fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
> Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

There is another report here [1] with a reproducer [2]. Even with this
patch, the reproducer can still trigger the warning on net-next. Don't
we also need to reject a negative ifindex in the ancillary header? At
least with the following diff the warning does not trigger anymore:

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7aba4d63b069..4a2ec33bfb51 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3560,6 +3560,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
        if (ifm->ifi_index > 0) {
                link_specified = true;
                dev = __dev_get_by_index(net, ifm->ifi_index);
+       } else if (ifm->ifi_index < 0) {
+               NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+               return -EINVAL;
        } else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
                link_specified = true;
                dev = rtnl_dev_get(net, tb);

[1] https://syzkaller.appspot.com/text?tag=CrashReport&x=178edad3a80000
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=166ed6bba80000
