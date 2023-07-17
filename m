Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210DE755E77
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGQIax (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQIav (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 04:30:51 -0400
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [IPv6:2001:41d0:203:375::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E3E3
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 01:30:50 -0700 (PDT)
Date:   Mon, 17 Jul 2023 18:27:09 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689582648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOmp5hitjZ7fhm1BXyLkFc2kTKDhZG8EGRqz2ebffbc=;
        b=GpXQf4zV2MwaDwhojYBOz5NC3XWNInzUGL9/0EirKSVhkIYqIJUXbUW8pkL6ukdaeW7FKE
        yZAjZCIPZufRStV9/QjGJBAvYi6ZijuhVWLYOU+IrU2AeHam8JGb2mK5exfQxf+an2AaPd
        I4Z/lvhjSF74e+9vL/MR4b7YiUMxgYQwYoft/Nm/PDk1F7K42H4DSRK1EkvlDpZgYJkppm
        JYAC5jQl53ExB+Gb0lg6AaJ7kRSMfhy3/38OrpD9RndOhYRby9eAE2NWAo1tXN4wU5obhU
        WhzbMoQe2Hi7Vf2OYHDLF596+3CaK8dHwUc8hPzKzl1D99agbwLgUkGRllzuGw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/4] Add support for Allwinner D1 CAN controllers
Message-ID: <ZLT7XYUziT11D8Nj@titan>
References: <20230715112523.2533742-1-contact@jookia.org>
 <96641e09-c676-2702-149c-885002f45a64@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96641e09-c676-2702-149c-885002f45a64@codethink.co.uk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jul 17, 2023 at 09:00:47AM +0100, Ben Dooks wrote:
> On 15/07/2023 12:25, Jookia wrote:
> > From: John Watts <contact@jookia.org>
> 
> It would be better if you sent your sending email to be the same
> as the from, I think you'd technically need a signed-off-by from
> "Jookia" as well.

Yes, this was a msmtp mistake. Will be fixed in v2.

> 
> -- 
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius
> 
> https://www.codethink.co.uk/privacy.html
> 

John.
