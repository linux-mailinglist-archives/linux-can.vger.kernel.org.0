Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B006782FA6
	for <lists+linux-can@lfdr.de>; Mon, 21 Aug 2023 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjHURsu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Aug 2023 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjHURss (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Aug 2023 13:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1AD113
        for <linux-can@vger.kernel.org>; Mon, 21 Aug 2023 10:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12AB261350
        for <linux-can@vger.kernel.org>; Mon, 21 Aug 2023 17:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB59C433C7;
        Mon, 21 Aug 2023 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692640126;
        bh=XZDt43brnFTJkb8ScLQNvWMVfoRbXfvHIPbaNmZldAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F6yDjvDCIsPvanRvMO9iP5ovPq8w7hv8wc9g7fkg0xbVHYVnJTD+KMBrgLS5lVWTH
         znqU9oXtTt+NfkBsSq3y+2AVLdXvIXqBp8iUwB8HR7x9mGi1TzhwCmBK3cO4B6HRS7
         E+T4PJXm1v6bhzzbs2O8uPBHaaYEsESUeE3HavF4sXHAK+uXw2x3xnbETG/N8SvJ6q
         Q5t5YU8mIqIVHWRS7D/eySV230GwrXA7iSEAJRHtL4Xd47ecpMG1JbybOQOPHIDqJ1
         bQOyBOmoxbwMBvek8X5nOA2ptpja3emOax+vjUvWswoTL+nsoaIETxXarARXgyEoxJ
         yVcQH2bSjL8rQ==
Date:   Mon, 21 Aug 2023 10:48:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        wg@grandegger.com, mkl@pengutronix.de, idosch@nvidia.com,
        lucien.xin@gmail.com, xemul@parallels.com, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
Message-ID: <20230821104844.19dd4563@kernel.org>
In-Reply-To: <ZOI6bf86B1fVb1sF@shredder>
References: <20230819012602.239550-1-kuba@kernel.org>
        <ZOI6bf86B1fVb1sF@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 20 Aug 2023 19:08:13 +0300 Ido Schimmel wrote:
> There is another report here [1] with a reproducer [2]. Even with this
> patch, the reproducer can still trigger the warning on net-next. Don't
> we also need to reject a negative ifindex in the ancillary header? At
> least with the following diff the warning does not trigger anymore:

Yeah, definitely, please go ahead and submit.

Is "ancillary header" used more commonly as a term? in gnel we usually
call this thing "user header" or "fixed header".
