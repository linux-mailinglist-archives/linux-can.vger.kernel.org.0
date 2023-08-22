Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F27783E08
	for <lists+linux-can@lfdr.de>; Tue, 22 Aug 2023 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHVKjp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Aug 2023 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjHVKjp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Aug 2023 06:39:45 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CFDFB;
        Tue, 22 Aug 2023 03:39:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BD2B2320092E;
        Tue, 22 Aug 2023 06:39:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692700773; x=1692787173; bh=TYcehPDeyWrpL
        ZI5nP9k0xeqXJO/gx+RoM3vlGRe1m0=; b=vxFbAE0yutGX+jZWygqwFfC9EQ3z/
        CqINau8nxSRe0lN/K161c5bu3rDwH+4jaxorjkcUrp/Qqgl1P8WGj2q0EiEE9Pi7
        hoYHiPNJh9KcL5Z+7mAgFh9VYj6fljpMxXSy2GpRyMERKZavPUop8gmcdz8qkwjT
        8JhniTUCSeB54rNgo+S/Ya2NSzWGngky5cwBxlQGNd3M3gm9lLJxkNR+Ku461nGw
        cDhfkB0AeZ5PVKYNkH3+YBjqmM4dm01cqhLAePed6H+x/whs4rqZqWBxiAOdNAb8
        1EAWlqs2AqQES93sqBfXpHiMBMc6dJKTBD/LT6xICvU+DMCkROfqJDxNg==
X-ME-Sender: <xms:ZJDkZHpzk1vzxcQeNTxuKacqQhN2HvVwdj1KdTTgpv_QEHiz8ZDTtA>
    <xme:ZJDkZBrj9f8bS7sqwrJpUxhJ7vg6ZHje6obW5oBMYfwxeMayjc4tC9t2iVGDOYsBc
    kS6EJTHk-ylk6k>
X-ME-Received: <xmr:ZJDkZENmE8WuAl3Qv4_b2pjbB9nuSkbHwuf7PwRTIfV9yGKrpFpclzm8klDSYEzo3ov3rqr79_DfWg28GCXCeTpQP99Ffw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgf
    duieefudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:ZJDkZK4oyvtDv9vONxzsmVhYbmthUoMPMlZYdulCyAfbXOmdOrU11w>
    <xmx:ZJDkZG5qS3a8raM6n88JfT9EerGmQzR4TPDfZODap8DF60tlQj86Lw>
    <xmx:ZJDkZCjBCSJ8C4jEQ9yL4t4htrhvsF7lwQ17K-DjqT1AQfeblGL3nw>
    <xmx:ZZDkZDx0OaoUA68RJ2LcgVXo_KwYYqRjbhMU3vOnTciviT5dVQI_Zg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 06:39:31 -0400 (EDT)
Date:   Tue, 22 Aug 2023 13:39:27 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        wg@grandegger.com, mkl@pengutronix.de, idosch@nvidia.com,
        lucien.xin@gmail.com, xemul@parallels.com, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
Message-ID: <ZOSQX1iXMzNOOhXP@shredder>
References: <20230819012602.239550-1-kuba@kernel.org>
 <ZOI6bf86B1fVb1sF@shredder>
 <20230821104844.19dd4563@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821104844.19dd4563@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Aug 21, 2023 at 10:48:44AM -0700, Jakub Kicinski wrote:
> On Sun, 20 Aug 2023 19:08:13 +0300 Ido Schimmel wrote:
> > There is another report here [1] with a reproducer [2]. Even with this
> > patch, the reproducer can still trigger the warning on net-next. Don't
> > we also need to reject a negative ifindex in the ancillary header? At
> > least with the following diff the warning does not trigger anymore:
> 
> Yeah, definitely, please go ahead and submit.

Sure, will submit tomorrow morning.

> Is "ancillary header" used more commonly as a term? in gnel we usually
> call this thing "user header" or "fixed header".

I honestly don't know. IIRC I saw David using the term a few years ago
and decided to adopt it.
