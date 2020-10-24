Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED531297C30
	for <lists+linux-can@lfdr.de>; Sat, 24 Oct 2020 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761201AbgJXMBG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Oct 2020 08:01:06 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39008 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759995AbgJXMBF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Oct 2020 08:01:05 -0400
Received: by mail-yb1-f194.google.com with SMTP id 67so3537272ybt.6
        for <linux-can@vger.kernel.org>; Sat, 24 Oct 2020 05:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Tqt+MbUkC/Sk9d6r/UeFk+yDqea+yPltsfdaFsFaBY=;
        b=n/Oy0T+SIbyLbVjFZlfynqoPqOFzSeb8OSXWt68PibvueVxtRJ8iW9IezY+0vTdMox
         n25Ni2fIJSsfFWoVhN9RzVnJCJBj3tVIvnQln5qFGwv52tkhVawi5KJKNDVPOMok1EV1
         qZutq5aLf1xaloKZWaH5WjsCWGZqtuDowj4HliY6boTrC44xMk+gKvhTSEgpfH0qLS3a
         LJ2h324H4qa/OK1D5/7Sm22IKWIMY7Rn4MU3yUA8wUZkAUnCpkeAHy15hGaj6umzK8U/
         lcr+W12jXZMGVV7MbnZjOB8mMPu6PK9wu+1fZ1VXR7hHhTeqR2yKt6kC7d302MeQ3pBR
         E3sg==
X-Gm-Message-State: AOAM531vfJWacD3Bhpl8n23GyG9XTj5oV2y7aA09vqig1kqf2LM+4l9T
        s6vH/HCZQg0/NO3xH2WUAiGthh6K4l8CmwkBhNo=
X-Google-Smtp-Source: ABdhPJz9t4q8CaMqaRc/1pYHKRPPLQ0v3zuDccHVPU7olzthwhYoNkPTHF9ytPcjlJuF3xKCVqp0RR6OugDCvB9WDbY=
X-Received: by 2002:a25:8382:: with SMTP id t2mr11192407ybk.125.1603540863080;
 Sat, 24 Oct 2020 05:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201023203017.3485-1-socketcan@hartkopp.net>
In-Reply-To: <20201023203017.3485-1-socketcan@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 24 Oct 2020 21:00:52 +0900
Message-ID: <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I did some tests:

  * Applied the patch

  * Modified my driver

  * Modified drivers/net/can/dev.c:can_changelink() to force the
    CAN_CTRLMODE_CC_LEN8_DLC on (this is just me being lazy to do it
    from userland).

  * Modified cansend and candump from can-utils to be able to
    respectively send and print DLCs greater than 8.

  * Set up two channels can0 and can1 and connected those to the same
    bus.

  * Ran 'cangen can0' and 'candump any' simultaneously.


Results of candump:
  can0  539   [8]  05 21 8C 5C F7 B0 7C 69
  can1  539   [8]  05 21 8C 5C F7 B0 7C 69
  can0  47E   [1]  53
  can1  47E   [1]  53
  can0  317   [6]  E5 00 B5 73 66 CF
  can1  317   [6]  E5 00 B5 73 66 CF
  can0  524   [E]  64 C3 B0 6E 55 7A D7 2E
  can1  524   [E]  64 C3 B0 6E 55 7A D7 2E
  can0  39C   [D]  63 18 96 69 F6 7A AB 36
  can1  39C   [D]  63 18 96 69 F6 7A AB 36
  can0  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
  can1  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
  can0  5DD   [9]  7E 55 56 5B C0 23 B0 53
  can1  5DD   [9]  7E 55 56 5B C0 23 B0 53
  can0  573   [E]  20 8E A3 31 1B 54 B2 16
  can1  573   [E]  20 8E A3 31 1B 54 B2 16
  can0  470   [3]  31 9C 06
  can1  470   [3]  31 9C 06
  can0  465   [4]  93 75 A2 08
  can1  465   [4]  93 75 A2 08


Works fine :-)
Thanks Oliver!


Yours sincerely,
Vincent Mailhol
