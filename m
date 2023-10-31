Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72EB7DD3D6
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJaREY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbjJaRD5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 13:03:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718D386F;
        Tue, 31 Oct 2023 09:52:51 -0700 (PDT)
Date:   Tue, 31 Oct 2023 17:52:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698771167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aAD4PZZPRqR2qqqz8EHQ+Hmek2C4MZMfqNDCeCXy6SU=;
        b=xICgJ7CKCPP612P/GeGfpN7jEdqws8T9RkJ5uBAsvulrBrYFMRnTyjjb0KmmXf/beQw/IT
        zBym7HVItEc55tJ/UFv0ACD3UNdpV/tCxHgpi7LHAUv4l5L+5yI11v2GQctUM0Vhu8sJen
        hmqRnvBzszDs9QME3/Cp/aV9g4S5F9fbOQuO6MANPi2H1rIpNQOzdhuBEdbGJBBbL9e1Ea
        Fz/8eG7oFPAyFkYb4k0hEqlR7+hAmZsyFFbpWWSFnLWEIcruogq2uPRpVgIrgcFOeusJyz
        eOG2+RLIQo2QjDW1onheqOtT76r6FAOXEtv3tPF7BdsIwdN5+7RodzCLEY4kBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698771167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aAD4PZZPRqR2qqqz8EHQ+Hmek2C4MZMfqNDCeCXy6SU=;
        b=iK28zELFzCeYTkCb2gCtc0jpeTewvtKn2reWTzzJxY/VQxP9ZdPySwiv/alRNwHNnCXfvu
        nltW1oFCxqmJDrBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Questionable RCU/BH usage in cgw_create_job().
Message-ID: <20231031165245.-pTSiGsg@linutronix.de>
References: <20231031112349.y0aLoBrz@linutronix.de>
 <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2023-10-31 17:14:01 [+0100], Oliver Hartkopp wrote:
> Hi Sebastian,
Hi Oliver,

> The content of gwj->mod can be overwritten with new modification rules at
> runtime. But this update (with memcpy) has to take place when there is no
> incoming network traffic.

This is my assumption. But "no incoming network traffic" is not ensured,
right?

> > If not, my suggestion would be replacing the bh-off, memcpy part with:
> > |		old_mod = rcu_replace_pointer(gwj->mod, new_mod, true);
> > |		kfree_rcu_mightsleep(old_mod);
> > 
> > and doing the needed pointer replacement with for struct cgw_job::mod
> > and RCU annotation.
> 
> Replacing a pointer does not copy any data to the cf_mod structure, right?

Yes. The cf_mod data structure is embedded into cgw_job. So it would
have to become a pointer. Then cgw_create_job() would create a new
cf_mod via cgw_parse_attr() but it would be a new allocated structure
instead on stack like it is now. And then in the existing case you would
do the swap. Otherwise (non-existing, brand new) it becomes part of the
new created cgw_job.

The point is to replace/ update cf_mod at runtime while following RCU
rules so always either new or the old object is observed. Never an
intermediate step.

> Best regards,
> Oliver

Sebastian
