Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE634BB5A
	for <lists+linux-can@lfdr.de>; Sun, 28 Mar 2021 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhC1Gbz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Mar 2021 02:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhC1Gb0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Mar 2021 02:31:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB84CC061762
        for <linux-can@vger.kernel.org>; Sat, 27 Mar 2021 23:31:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o66so10300457ybg.10
        for <linux-can@vger.kernel.org>; Sat, 27 Mar 2021 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+qWYn1hSdRIVBHQHbWXIxh/qjNFpXHdieofhcKfb/ys=;
        b=un5ugo9bupqrzZuaBDEbB786JWEzOQTNdwphXi4TOqH9iSP+44sC/hABKBkrd5PRtf
         7jZx0pPsKeCWa97uNLMVrxcUbXHvpyoBn5oZYNAQFZsmvyS2liGWbAih8Qo/juVJGCzw
         Y16g0hPbvSZtfV7CLm9ZaDSsZyOkcdd3roHlRv6xJ+OmFx8tEUguEZyn8zBrxBjk/HtR
         dyf9+rh7TFsjL0A7AdpBP6TqBjy5+u/bfausEvolq7MwJ6du/43NJnkt8pCLIlzELbih
         GgycRMRIUYRaoHxZdjTU6NIUvq0hWr2tRmOwwsRt0IOmTuJTvn2J9bkg0EKDwCYhtPNW
         SqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+qWYn1hSdRIVBHQHbWXIxh/qjNFpXHdieofhcKfb/ys=;
        b=eED9lnZoqx+CcZK7brYHwomgOntFioVDOFWfLW1hQK3ZuSZbRvMEkzIjV05TJ+s7Gt
         fl//WnBM5hAR65qc/KC/WLnNndnBz5c0NaTi4RDHvjNcGAnMsc8ZXI1aBiymA2SCGUOn
         5ywFrNGsNhwH00nVLCimHzaKStaKO+/QsKzNoqhYh59pw2foytqZs8Ckw5H0M6wnBgvv
         mhff5HAfKfQbhq99D2p6HHH/fHtL0XEeLtVrxUGvt+3ogp+sg0zStjngwVBGQT/9OuXV
         1Qd5kcKuoh++LGk3bBCeDNb35mROb3HF6J3nxtjkouzfHSzhwO48StSuTpjCwfAoYIh0
         mI7A==
X-Gm-Message-State: AOAM530b27uFJplnJMo2K47mA9/eqpbd6VqfdX2j6E8MCV693Njw4MOU
        Ty3ldZ/AERFILB+U3r9ELOm5PgpeqzQWrZZu3I08cZUO2HkE+zAl
X-Google-Smtp-Source: ABdhPJyH177l3kLMciSz+F2h7fE/2KJD26NzaPVAQcXeg491DZUuRqEA5sRQSzEZw5XltCBNgmf5XVS5jqjuvTMUPXU=
X-Received: by 2002:a25:ae8c:: with SMTP id b12mr30625767ybj.173.1616913084786;
 Sat, 27 Mar 2021 23:31:24 -0700 (PDT)
MIME-Version: 1.0
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Sun, 28 Mar 2021 08:31:14 +0200
Message-ID: <CAAfyv37vMxhN2B1uR5xUzZwVzAqrQOyPA6stWYj_5346xO0s3A@mail.gmail.com>
Subject: m_can error/overrun frames on high speed
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I have a beaglebone based board and I'm performing some tests. I
discovered that when set bitrate to 500k during replaying can file
from PC to board ip detect 4-5 error/overrun frames. When comparing
the original file with received one few lines in candump are missing.
When decreased can speed to 125KB replaying the same file no
error/overruns are detected and files are the same. I'm not can expert
thus I'm asking for some advice on how to debug such phenomena. I'm
using mainline 4.12 kernel which shows this symptom. I compared
changes with the latest mainline kernel and there are few patches only
which seems can influence can behavior (others are only cosmetical). I
took :

3cb3eaac52c0f145d895f4b6c22834d5f02b8569 - can: c_can: c_can_poll():
only read status register after status IRQ
23c5a9488f076bab336177cd1d1a366bd8ddf087 - can: c_can: D_CAN:
c_can_chip_config(): perform a sofware reset on open
6f12001ad5e79d0a0b08c599731d45c34cafd376 - can: c_can: C_CAN: add bus
recovery events

I know most of the answers for such issues is to try latest kernel
(i'm in process trying 5.10).

Thanks and BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
