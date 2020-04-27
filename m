Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0DF1BA1A2
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2020 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0Ksw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Apr 2020 06:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgD0Ksw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Apr 2020 06:48:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B0C0610D5
        for <linux-can@vger.kernel.org>; Mon, 27 Apr 2020 03:48:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g13so19948684wrb.8
        for <linux-can@vger.kernel.org>; Mon, 27 Apr 2020 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UY1WYhdQPpaPwS96iqv6siUU/YitOCVbA3dJz/qM/vE=;
        b=UFvcxwJCORFbx87uc3mpAH9/mbfET/VHZrwYKvAACifNUpp4Ub0XPoX8ijj7M2XWb9
         oWJ9NQ2PR1+EWhu7JozNM9yy4P6RFaxchkBlj9trLD2fcBfxtgU4bGRCK2rFS9LuKB6O
         pxFyStngVTaBynx4bh/v0IxnXP8gHPG8Ds7bGU5gnWDQtRQvQuS7d0XLwL72vXSkgOZa
         bXKuzsotEoLae5EV0w4UQ1Ic0bjC6Kdv1HZ3IATMGFcKDr4t9ewAB0WmKLLCNEYuIU4u
         bdDRkgfW6NZNMPxl6YI1YtPStdLH2ACdGF7gypU6vltNcJNz0/pMNDQmGY+SX0FX6PG0
         GaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UY1WYhdQPpaPwS96iqv6siUU/YitOCVbA3dJz/qM/vE=;
        b=sxUD9rd3jCOhBB8xvs0sFpED1jSQr2O75bkqDMHoYH3kVpUs16G2C7QtOG1fMyLyIx
         N2q/Fe2hi7zOIKiqQrNFQ5jX4J7oEI1x4PL00NMlS+D+35scJoWLM81pt7S8FGh++vaL
         MX9wdNzUkVruJnTyFXzTl0kIFRg62Uf2aaB3pfasx0g+z5mw7mU5+SGQMhXOFwUlJK8N
         nFYN4y0UaizTyaZv9rePdou3iIKBMARzZbzsAsUfX24/y3TI5R4ARyCSRxZIKwrFk4EG
         4gjp3l/xEbxBTARiFfVwvUmTM1awSayLWU2V5DwOhiRj5OhyhMkhDZszXX5VimB9juJc
         VT2A==
X-Gm-Message-State: AGi0PuZpM08vEAwIbWSnlMOTNCOuw52rzWOSSxhwg4Fi6hqEiB7gxh3+
        yogYCVeC8KvCWqx/cR9ev4mm2JfNYAi35Pq/9uQpqlN+
X-Google-Smtp-Source: APiQypJZEAV/VQfRg6Y+N070vY2Wvin1X4exllhSe90NzvQGW8rYnWmSlSHQ7gMT8LmGgCAWODznf2MYGUBx5Bai0W4=
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr24845350wrp.285.1587984530204;
 Mon, 27 Apr 2020 03:48:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Mon, 27 Apr 2020 13:48:39 +0300
Message-ID: <CAP22eLEefVnmatvz1yn8g09o1v_YRs3NS=_ybhF_-WmquiUaLQ@mail.gmail.com>
Subject: Is is possible to use Netfilter for outgoing CAN msgs by CAN-ID?
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Thanks to Chris and Pavel, you helped me to sharpen my question. so I
rephrased my original question and learn things.

 At first glance the answer should be definitely YES.

Since CAN-ID lives in sk_buff and Netfilter hook receives sk_buff as a
parameter there should not be a problem

But I did not find any such module by googling.
