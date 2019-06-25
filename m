Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E270F55107
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2019 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfFYOEh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jun 2019 10:04:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40972 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfFYOEh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2019 10:04:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id y185so7551215ywy.8
        for <linux-can@vger.kernel.org>; Tue, 25 Jun 2019 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pIIC3jytWsmntojJM5beMPwkkISJ/lE+BJnG08AcnU=;
        b=mRU4gBCrfg1gioLKe8ve3oGpbXdbfnB/ITSmqUQ9RcKXPtDFqmjktz9gM9ltsUh+wg
         yUOjr6uBYr3ljB+H8Qpntj89LzaLJ8o3QlvN9SRou/ztu9mINIl4ZYYaTN4BJuuYlANb
         Ut0kJmWvQM9BgB5orcacPdtvxfMMYeSgbJvugc/6SVKkKeNPc9WXLZlNEwSzV7Jyz7dw
         D2YbmYBouyrHwbDsgfzL+et32rsvUyNbdFc2SUx5jusN9rhLxCH4jZgtjKHlro+olg7q
         B0MwiYxTbk+3sGmNj0ndHj6Tn9PKidy1jzuvBQtDn3VADbLLRGWJqFTBKEe1779CkJhT
         49Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pIIC3jytWsmntojJM5beMPwkkISJ/lE+BJnG08AcnU=;
        b=cK0ye7T/ZXd5rEGXRn4hm2duk0EaX1cOkxQ+Wd2lADeXKNc2pqMgxxKRgGnCC7Xpz8
         /0ToTlO8DaCXhStmZw9/p6JQGfFP5xoIH5XbkYawhIaCToYtH2FVrEvclkURgpg4SDe+
         PIc2iWvEiUU/XcbKWt2Slacti3wc3qyS7JuVc2P6FI4iwqmXzdGWM0/9I6ddmOedl3hz
         BxQvD0VlVLeGBSNid9/Qe3zA6DUOA58dFqM8XKCaYqJ/DuIaRKkffi3mGzXVe206Rea1
         T2a5h1YrZ2ddiHfDXLyr7mZiaYHojTiVOAw50cLrQuvOBHjHLQYMWn1EMMh5c+AvjuCN
         4KbQ==
X-Gm-Message-State: APjAAAUFxBmqVuMfXuZT4R7CUY5eh+I2Z+AmlKShnVD323nopIlBNK7d
        MshhoohYxu52062Ws5Cc0QGAu8l2
X-Google-Smtp-Source: APXvYqyYAh5SXJI8Ha+49jkGF/ZWxgPRKQkP13nJZgcGqcBDGZWfT0p8ata1SYKl2v2DHTqIFpCmLw==
X-Received: by 2002:a81:a18b:: with SMTP id y133mr76129497ywg.239.1561471475523;
        Tue, 25 Jun 2019 07:04:35 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id q63sm3636305ywq.17.2019.06.25.07.04.33
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:04:34 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id i14so7491858ybp.7
        for <linux-can@vger.kernel.org>; Tue, 25 Jun 2019 07:04:33 -0700 (PDT)
X-Received: by 2002:a25:99c4:: with SMTP id q4mr11512887ybo.390.1561471473136;
 Tue, 25 Jun 2019 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190625125048.28849-1-houweitaoo@gmail.com>
In-Reply-To: <20190625125048.28849-1-houweitaoo@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 25 Jun 2019 10:03:56 -0400
X-Gmail-Original-Message-ID: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Message-ID: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: add error check when wq alloc failed
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, sean@geanix.com,
        linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Jun 25, 2019 at 8:51 AM Weitao Hou <houweitaoo@gmail.com> wrote:
>
> add error check when workqueue alloc failed, and remove
> redundant code to make it clear
>
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>
