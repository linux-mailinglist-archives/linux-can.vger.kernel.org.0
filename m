Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739C56D2185
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjCaNhf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjCaNhe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 09:37:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81821EA17
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 06:37:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so89727910edb.4
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680269852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA2jo3l12jR13M/qRztMCg7kF6jWkpPXK6bkSm4Oy2w=;
        b=BqfgpGl7uDSihtIfEVsOsypXEK7oC5E4OOqT8BfuO6FM6/+BPmOoFYHMfj2O5ma4js
         VY/I+q87h6KHqWHrritdcBs/a0XGOSPFZG4vFTbSxeJHy+G9IMc89RzIVGSh6IqwYUiU
         M2q7pIKlEGoxhh4qeOoaXsq13d0uSwto1lf+hClZ93x4JUjvqSXsp9zKCUjeG5Qve0hN
         Yl4YHQTFOIiKKeBSvygJqDx+FJZvnd02eKZU7Sniop9/YHZIMiFgeWsgIzn8C6t74ury
         xz94gEW100SBtMAoRVu+ruRr1uxjrYz37wPD8rjxCrhjU775uW3iXkEtQ+dcZTo4AjLY
         hxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680269852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA2jo3l12jR13M/qRztMCg7kF6jWkpPXK6bkSm4Oy2w=;
        b=3y2TyFxxK4R8OCN522XbxJvBt6iVPGIAnyVi8bGDzZELyXFfTho3wKedff4YYM+RP5
         EkxthbLNvS4EXmFyntEriJIq+kY0Lg1fOD9BlNDegCziFqMPybmOAX6u0Kz8CzQ7efp9
         IiziNxUQpX++QJeJjTaBbOIYgJffqFxr3BpYUinAwma9bivuKGXDGgzwXF/OIiUyZtEB
         YAbRCsb5t9xlUIXrHPNnZwdzco+G07D3/pswcqCOMJKntFBseVwBvwQ28P36p5pxkHVM
         h7XTmZrqk1A4Xnd4+PATnltkE/trpZptFHj3hXUwNo5vME8ivXf2uVB57lXLXrXc0Rbs
         SOWA==
X-Gm-Message-State: AAQBX9cEM9X2qLwaOnUPDQrlhEp/K9tdUlh8zCq6zO7e572iBLiey5C2
        dLiUFCdmIU1EGOck5RW7UXZ1gLYglmO24g+3ICg2FU0d
X-Google-Smtp-Source: AKy350YSFE8uvblag6wxbEcuzdmZvD+2cPkWR/UQW65wQyn8JFwA8x+LKbvnzPiupZWvRig3PLkkGnkmmlk3fQva/dE=
X-Received: by 2002:a17:907:d68c:b0:947:556e:ed3 with SMTP id
 wf12-20020a170907d68c00b00947556e0ed3mr3417224ejc.11.1680269852262; Fri, 31
 Mar 2023 06:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230331102114.15164-1-socketcan@hartkopp.net>
 <ZCbM0mTZFgfyWndH@dragonet> <bb365ad4-815f-4dac-6e40-83b7197b5033@hartkopp.net>
In-Reply-To: <bb365ad4-815f-4dac-6e40-83b7197b5033@hartkopp.net>
From:   "Dae R. Jeong" <threeearcat@gmail.com>
Date:   Fri, 31 Mar 2023 22:37:16 +0900
Message-ID: <CACsK=jdYFQATbs_u-AQr8ota4he17xVY--t3jFAx5y5WW-qqxg@mail.gmail.com>
Subject: Re: [RFC PATCH] can: isotp: fix race between isotp_sendsmg() and isotp_release()
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Mar 31, 2023 at 9:23=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp=
.net> wrote:
>
> Hi Dae,
>
(...)
>
> /* wait for complete transmission of current pdu */
> while (wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_IDLE)=
 =3D=3D
> 0 &&
>         cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) !=3D ISOTP_IDL=
E);

I'm not sure, but your intention in this condition is probably
while (wait_event_interruptible() !=3D 0 || cmpxchg() !=3D ISOTP_IDLE)?
So, release() can get out of the loop only if
wait_event_interruptible() returns 0 and cmpxchg() successes?

> /* force state machines to be idle also when a signal occurred */
> so->tx.state =3D ISOTP_SHUTDOWN;
> so->rx.state =3D ISOTP_IDLE;
>
> When wait_event_interruptible() does not return '0' we can neither rely
> on tx.state to be ISOTP_IDLE nor on anybody else taking care for that.
>
> So I would suggest to continue removing the socket.
>
> > Thank you for your hard work!
>
> Thanks for the review and the request to take an additional look at the
> code!
>
> Best regards,
> Oliver

Best regards,
Dae R. Jeong
