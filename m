Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F677152A2
	for <lists+linux-can@lfdr.de>; Tue, 30 May 2023 02:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE3Aqj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 20:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3Aqj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 20:46:39 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044FC7
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 17:46:38 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b04949e4e9so7368775ad.3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 17:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685407597; x=1687999597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSqA+J38MgSr1tUZYIk9mTn6j85AbTnuALoH/4moN7I=;
        b=CIt7RgTn+cMDUMn7ddsnC+PcbclBW9icNo2NkPyF7774VBDAyZdt3Gk1PIDM9lJgPM
         C4WmwXqRj/1BcUQIu+8MHTK9qpQ0W77mXo6IecaeJXD5FNKsoLx6okJUAHtbYF8IE0qv
         nn+X/JYBx3X3VPygw46GgAghYLlLDUgaMq3RT98Zt5kb4a34D5IOQTpo6GvYfw+EdsSC
         zUkADdY/h/0bBOf3NDIcK58BbKOGxB8xSRwSFrXeYSTlcwUaKunpT+dEAlHg8M6rAL8q
         7JdUbVjxHWr/JjNTzhcj2FvTJnyPDPWBD0pm9dl+kuCRUt5h23tDlmsnEOupMV95TryH
         Hyeg==
X-Gm-Message-State: AC+VfDz6cuJxXaTRqfMv0N6v8UOJ/5DKQYe4f6MyrZp9W7TMslhcKfAL
        ULJPiVNhPmT6ziSDDl+dPvOzP50O7Dz2OxBVrimP0jQHukE=
X-Google-Smtp-Source: ACHHUZ7EsFwB80RcIXQlzeKmWqjANQRVO6plc2vyjb4exoTktQgGGw+uCPOhWndRBt98YIPxfYfNCZKQ1BtQIO+bV6c=
X-Received: by 2002:a17:902:e5c2:b0:1a9:8d57:6d6c with SMTP id
 u2-20020a170902e5c200b001a98d576d6cmr842111plf.24.1685407597290; Mon, 29 May
 2023 17:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230529134248.752036-1-extja@kvaser.com>
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 30 May 2023 09:46:25 +0900
Message-ID: <CAMZ6RqK1v3v1+v4S-1bpMVmYWnHjvEbJAU6+6V+a8jtM7jLFGA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] can: kvaser_pciefd: Fixes and improvments
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 29 May 2023 at 22:42, Jimmy Assarsson <extja@kvaser.com> wrote:
> This patch series contains various non critical fixes and improvments for
> the kvaser_pciefd driver.
>
> Jimmy Assarsson (14):
>   can: kvaser_pciefd: Remove useless write to interrupt register
>   can: kvaser_pciefd: Remove handler for unused
>     KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
>   can: kvaser_pciefd: Add function to set skb hwtstamps
>   can: kvaser_pciefd: Set hardware timestamp on transmitted packets
>   can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
>   can: kvaser_pciefd: Remove SPI flash parameter read functionality
>   can: kvaser_pciefd: Sort includes in alphabetic order
>   can: kvaser_pciefd: Rename device ID defines
>   can: kvaser_pciefd: Change return type for
>     kvaser_pciefd_{receive,transmit,set_tx}_irq()
>   can: kvaser_pciefd: Sort register definitions
>   can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate
>   can: kvaser_pciefd: Add len8_dlc support
>   can: kvaser_pciefd: Refactor code
>   can: kvaser_pciefd: Use TX FIFO size read from CAN controller
>
>  drivers/net/can/Kconfig         |   3 +-
>  drivers/net/can/kvaser_pciefd.c | 955 ++++++++++++--------------------
>  2 files changed, 342 insertions(+), 616 deletions(-)
>
> --
> Changes in v2:
>   - Add new patches, to replace opencoded masking+shifting with
>     FIELD_{GET,PREP} and GENMASK, suggested by Vincent MAILHOL [1]

Thanks for addressing my comments.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> [1] https://lore.kernel.org/linux-can/5b10f6cd-c96c-3198-3df4-557e5e91b2e7@kvaser.com/T/#m14c3851e70cfb8c903388e068968a4a379d183e6
>
> 2.40.0
>
