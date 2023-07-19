Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECF5758E24
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGSGxf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGSGxe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 02:53:34 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8991FC4
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 23:53:31 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:52:46 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689749609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lc9Aiu6PXaiP7fZ39vLAvDfId+QeqHYOYEE/jCSgr4k=;
        b=EutD7K3D+v5ucF4MRVCpzb04OEpQRUCikJigDSzA0eiUMOjhsaODcLGcBPF0AnKQMvVhld
        ljLrR5rUxmrMGH/m1UzntBC/fvc5KoLQd5hZW3Lg7stDUnJuJWWaZ6iToAoQpi0/+JwATA
        DSgzmtiTVQfSsBMzBeXcILXn7f2ocQeoPXBmi+uETsZRGmZqO9CecMeOlB/dT4iS0rdGSB
        9r0dyfcR23BCxF8D2gGheOi5UxkdjBKitoKzfMErYbfoqx9i5bincWEoevHvR0csNc1WSu
        u1AjR8Ykh4OZ8R54ddMqjIxg5k10C5FcBWRpvobo8yYTsUuLhtcDsl+FUZmBnw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/4] Add support for Allwinner D1 CAN controllers
Message-ID: <ZLeIPnpQnFq1qmfF@titan>
References: <20230715112523.2533742-1-contact@jookia.org>
 <96641e09-c676-2702-149c-885002f45a64@codethink.co.uk>
 <20230718221504.GA2015343-robh@kernel.org>
 <20230718-matron-backlit-ddf56c391f8a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-matron-backlit-ddf56c391f8a@spud>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Jul 18, 2023 at 11:38:48PM +0100, Conor Dooley wrote:
> > The email needs to be an actual person. 'contact' doesn't appear to be 
> > one.
> 
> I don't think it is that complicated, a cursory check of the domain
> suggests that "Jookia" is a nickname & there's surely nothing wrong with
> not having your name in your email address.

Yes, this is the case. I figured contact@jookia.org was better than
jookia@jookia.org.

I generally go by my nickname online and in the open source community so
it's much more useful as an identifier in this case, but I've put my real
name here instead to make things easier on everyone.

John.
