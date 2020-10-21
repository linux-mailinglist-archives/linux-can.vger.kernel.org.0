Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED24294819
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 08:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411619AbgJUGXw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 02:23:52 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:45608 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408726AbgJUGXw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 02:23:52 -0400
Received: by mail-yb1-f178.google.com with SMTP id s89so793096ybi.12
        for <linux-can@vger.kernel.org>; Tue, 20 Oct 2020 23:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuQuqDCrL6Hu6gDM29TRnIBCq9vAzZ+4fyyt+FJInQA=;
        b=c/YLMWTlfiBmsNAb9nyp2f8XCbWuoPJimVEGfxFTibHte3rIEmWrbx7e5o9IssPZ7W
         2Las2Vs9MYEkaCHQLIyJc6AKX66uS++xs0/Uovth5YQ2HdhevgYoR+77jBrv5kW+zE/i
         0jsab/w5p+MzyzEvfmziVl4RT+27/ZOUGdLJrboYnyq76wPZjcrlSjTBqPcY50n8HYl+
         soa22UCV4dV4edsMvWglmVrJQgAC5DomRakYrqdmTbromDC4F82fsZ+5vA/f/NRZqEmY
         gLlJD69g/MqO5C2pBmonavNdtT96skhseEjeJigev/i7t+EX59kSzReGLbuzM8TuvHHc
         9vDQ==
X-Gm-Message-State: AOAM533GLNQAIg/ThDZArHVrjtnGJrMSmzXt1UM9fKf2hJqYfLzL/M9O
        gdMeoBQ42dXXXedLNIB3+PkwP5VufOoXOKeWJKo=
X-Google-Smtp-Source: ABdhPJxLV1z3/HYyYoZb08c07wRs96L9+qj5nTnWgZOzvo/Jg90hyw1LfAFsZWU1HzZtXYGVjw3uEPZQ1kkugya8r2E=
X-Received: by 2002:a25:15c9:: with SMTP id 192mr2692293ybv.145.1603261431494;
 Tue, 20 Oct 2020 23:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net> <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr> <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr> <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 21 Oct 2020 15:23:40 +0900
Message-ID: <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> > From a first thought I would see a new flag CAN_CTRLMODE_RAW_DLC in the
> > netlink interface of IFLA_CAN_CTRLMODE for the CAN controller driver.
> >
> > This could switch the sanitizing AND the CAN controller can properly
> > expose its ability to support this mode.
>
> Absolutely yes. In my first message, I mentioned the idea of managing
> that through socket option, glad that we now share the same idea.

Actually, I just realized that I replied to you too quickly. I was not
exactly thinking of the same thing here so let me correct what I
previously said.

IFLA_CAN_CTRLMODE is at the netlink level. My idea is to have it, in
addition, at the socket level. Example: add CAN_RAW_RAW_DLC in
include/uapi/linux/can/raw.h.

The reason is that if we only manage it at the netlink level, some
application not aware of the RAW_DLC issue might run into some buffer
overflow issue. Unless an application directly requests it, the current
behaviour should be maintained (rationale: do not break userland).

So the full picture will be to have both the CAN_CTRLMODE_RAW_DLC at
netlink level and CAN_RAW_RAW_DLC at the socket level (in the exact same
way we have both CAN_CTRLMODE_FD and CAN_RAW_FD_FRAMES for
CAN-FD).


Yours sincerely,
Vincent Mailhol
