Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16D02A36D9
	for <lists+linux-can@lfdr.de>; Mon,  2 Nov 2020 23:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKBW7R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Nov 2020 17:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgKBW7R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Nov 2020 17:59:17 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1000DC0617A6
        for <linux-can@vger.kernel.org>; Mon,  2 Nov 2020 14:59:17 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t143so4838063oif.10
        for <linux-can@vger.kernel.org>; Mon, 02 Nov 2020 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pIgbBf1uVZBJLBc5D8KblxG4A//HXosAxW7u85yDxVE=;
        b=cscgf4UENNPWGUc6kLu3WbtTtJc1SYK2SS5ueXLVRncO2izfrzr0juH6o5i1d9SzoM
         qC0+vemnKbfqtXi0gZZ07M5FF4ydHgf6pqu1cNMjGcb02WlqPm5HSw84jjhyszzPlJgf
         Xka7GKtyDCiTzt+q9j4cR7gNSr+CbyOQDvGMQQO8X8wR5t461Ii+HyNg463NfodEXUhd
         eUTV6+5yXod8oWkn7G2xoaLdDGaqJ66yE14aFbJSKAjXIMXDPO+Vw9+aRLxaL0WCVSQg
         eqopv+4iYoDGfvjAK6I1o9Au2531wkxGS+EiSqJInWWV48ZzGnLG32KK03SNZT1gjaU1
         eQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pIgbBf1uVZBJLBc5D8KblxG4A//HXosAxW7u85yDxVE=;
        b=OWIcLTxs2QCs2V5W5o+GOwp4f6U4dqDHF9DSZ9pbZ0o8M+gp07NL/twXMbNU0/4E9n
         OgvC6W7UAcwYEG54or+x24YPXMsfhj3Z33HkKANV/KHRDY0hUFyRIL7PkU+fIVuX1kZ6
         8veytLD2XAsBgJnd16geqXwrjeyGEVCKN0nfm93AQrwJkxiHJD05tUZCkWuOQhgS1uxc
         ih5Wcr3Yi0XkQ6+gfrWyKcLYXAV3qf9W/dZtnOzooCTnVasu/ll5Q5Mt6IzcCZwARXm2
         3ppzK0mXsNU4zHrE5s+AbrO53vpusBmNhxAmMYwsPfgO6ftzCm9OIEdGPO8Iuk6+HaiV
         M8IQ==
X-Gm-Message-State: AOAM532pP+wlnZSzNxt0NSIVRiyp/d9SDUQ5/uDuXXPp+sAkejyA5GSG
        ds+so1zjrjIaAP/CaKqZd/s4G5Dn28AHtdWM6JWRd/HAMEJB9UQD
X-Google-Smtp-Source: ABdhPJwr5K2+xMulem0PmJfpBpU9H4LuoZDesbjjgez+doVpkxrRDSV5r/O1ipl9nHGIK3q5Imr7nvqh7qbbEMNpVBc=
X-Received: by 2002:aca:b607:: with SMTP id g7mr270138oif.38.1604357956468;
 Mon, 02 Nov 2020 14:59:16 -0800 (PST)
MIME-Version: 1.0
From:   Drew Fustini <drew@beagleboard.org>
Date:   Mon, 2 Nov 2020 23:59:25 +0100
Message-ID: <CAPgEAj75pUnhOrvQ5basubGfpMoijpBonOsv-Wio=WP55dmFNw@mail.gmail.com>
Subject: Re: mcp251xfd: rx-int setting
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

I modified devm_gpiod_get_optional() in mcp251xfd_probe() to look for
"rx-int" instead of "microchip,rx-int".  Is there a reason it was
looking for "microchip,rx-int"?

I am using branch v5.4-rpi/mcp251xfd-20201022-54 at commit 9e02abd4fe59.

While it does now see the property, it does run into this issue:
[    6.830900] mcp251xfd spi0.0 (unnamed net_device) (uninitialized):
RX_INT active after softreset, disabling RX_INT support.

Any suggestions as to how to troubleshoot this?

Thanks,
Drew
