Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9355E150
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiF0OWf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Jun 2022 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiF0OWW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 10:22:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642113F07
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 07:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91F48B817DA
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 14:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E9EC341C8;
        Mon, 27 Jun 2022 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656339734;
        bh=t8SWVHvmZtlzKcyPnCGwMomZCx0VpuMdzGCcVa02adE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gofCUMgbOH7h0F3JyzfNK6NM1UKwgnWi/rzvv+Lx8odawyOvtLcQAJhdowjGWSal4
         uwn+YDa9rBFvWE5cOtj8rSBu2p8rY7e1o3VcfqBfDr4H6zBc1ZVlG16ZKPBs/Z/y3O
         +tmILAxkjN5mQWVbACiEqURzAKiumL4Ecp8RZjxo=
Date:   Mon, 27 Jun 2022 16:22:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     davem@davemloft.net, kuba@kernel.org, max@enpas.org,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: patch "tty: Add N_CAN327 line discipline ID for ELM327 based CAN
 driver" added to tty-linus
Message-ID: <Yrm9Ezlw1dLmIxyS@kroah.com>
References: <1656338186201221@kroah.com>
 <20220627141408.rdquaslehydluas6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627141408.rdquaslehydluas6@pengutronix.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 27, 2022 at 04:14:08PM +0200, Marc Kleine-Budde wrote:
> Hello Greg, David and Jakub,
> 
> On 27.06.2022 15:56:26, gregkh@linuxfoundation.org wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver
> > 
> > to my tty git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > in the tty-linus branch.
> > 
> > The patch will show up in the next release of the linux-next tree
> > (usually sometime within the next 24 hours during the week.)
> > 
> > The patch will hopefully also be merged in Linus's tree for the
> > next -rc kernel release.
> 
> This means this patch will go mainline with v5.20, right? The earliest
> this hits net-next/master will be after that, so the net-next for v5.21.
> 
> Is there a way to get this into net-next/master earlier? As Max has a
> CAN driver depending on the new line discipline ID added in this patch.

I have no objection for this patch to also go through the net-next
branch right now:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

That should solve the issue, right?

thanks,

greg k-h
