Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1555488E72
	for <lists+linux-can@lfdr.de>; Mon, 10 Jan 2022 02:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiAJB4Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 Jan 2022 20:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiAJB4Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Jan 2022 20:56:24 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F2C06173F
        for <linux-can@vger.kernel.org>; Sun,  9 Jan 2022 17:56:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso20586799pje.0
        for <linux-can@vger.kernel.org>; Sun, 09 Jan 2022 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/6G4gKPIEV11kuEavv5pF9D+VFx/ZQ4gl/RgU+Pd3o=;
        b=pOyEZqQJPEHxO0/yXqNwS89d/qbsTzVZWGwvuZpsQnlVNFV+L9RzaUKfaxoJ/YWd6d
         gB8KBUSMArbDPLLZk/++dt33bEe5s4aUAnx+yjrvVjboa+xNVe1DHqH1PdJdaxJ9hJJH
         vNA6UGB51sWxlX996rvdqnsdc1izd0hTtkzyW/ETWF3d7D5X1f+t4octpKyYk4WJaH5f
         v1qre951RUuh6M3t1f2ut2lJT5Rk77Y1MVrv5RUjtLzS/v62yl0K9rBrx+fq8GsLh8PL
         nZz0VJyfVx339KOXmICz/mD3lIRtFJY6QqkxRECyiSb5XTou3jKWos6zE7kFxqjV1stN
         8PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/6G4gKPIEV11kuEavv5pF9D+VFx/ZQ4gl/RgU+Pd3o=;
        b=P+UYdYozS7paQBZyclO9H3ex7f1ebDME/4r4UJrFObDgwBJTl0XT9L56f/ola3fK3l
         My2fOqKQXgFI9l7OUtM0Ci6DwqmeLjw9SNtx6VoWBtgeUJvGALTi2S+9zKAmuqubrHQB
         dYWcc4KRYN41DBlV41hxFOXoiiDsRcMDl9xO3sDpG2yhAudCIAapCXmiGnOqICQlyG3U
         TNUP26xvfeKS98gZsI6u6FrTlWy+Uuh3S2BiW3PwBtyXjrHQpl44eVjkDIwZkAFRYVDJ
         qvR1Qy4U2Q6V9tCri/JIAIAX49dfJdaM98SR3+hy+Ix6mfKEtksyoba3yPen2BvVG9NL
         F1aQ==
X-Gm-Message-State: AOAM533OcqKnOC8Sw4KIakkpYsxOk/KT1urz86sjPCXAc2uT+Etn/pAC
        uyUv9TtLRooWBTkd1kfozd0nwua2X68TFZs2evpw6p0S
X-Google-Smtp-Source: ABdhPJxHSxxortR/MFyhfQSA2do7DaElnxNTD4RDnR6EvKGHrHmdWJ8fcL1xkKLqs/fbASFbOu39Zq2TZBPywICNI7o=
X-Received: by 2002:a17:90a:7e8a:: with SMTP id j10mr27877488pjl.13.1641779784109;
 Sun, 09 Jan 2022 17:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20220106002952.25883-1-brian.silverman@bluerivertech.com>
 <20220108222904.plwxywgmnwrwpvmt@pengutronix.de> <20220108231655.oqzfap5yvh5xdumm@pengutronix.de>
 <CAP01z6Khm+s=HsdYh0+wUF6H3=mVYkvBE0x_g_Qw745VtNayYQ@mail.gmail.com> <20220109103922.db5km3dhy6wjaq5i@pengutronix.de>
In-Reply-To: <20220109103922.db5km3dhy6wjaq5i@pengutronix.de>
From:   Brian Silverman <bsilver16384@gmail.com>
Date:   Sun, 9 Jan 2022 17:55:57 -0800
Message-ID: <CAP01z6Ln84au-CwKk-68Qfy7mgDtPBpFGk0VV9WZ086uQA7vWw@mail.gmail.com>
Subject: Re: [PATCH] can: gs_usb: Zero-initialize flags
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, Jan 9, 2022 at 2:39 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Ok. We should map that non working email address to working one, having
> non working email addresses in quite annoying when sending patches.
>
> Basically there are two options:
>
> 1. Map your old bluerivertech.com address to a new address of yours,
>    e.g. your gmail address.
> 2. Map the bluerivertech.com address to someone else (i.e. a real
>    person) or a role account (e.g. kernel@bluerivertech.com).
>
> What do you prefer?

Map it to bsilver16384@gmail.com please.

Thanks,
Brian
