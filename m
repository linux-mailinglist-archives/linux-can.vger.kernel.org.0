Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD75667D5
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2019 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfGLHhI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Jul 2019 03:37:08 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39313 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLHhI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Jul 2019 03:37:08 -0400
Received: by mail-oi1-f181.google.com with SMTP id m202so6595079oig.6
        for <linux-can@vger.kernel.org>; Fri, 12 Jul 2019 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tct8NcMnuogShB9Wqv76Qs3Y6s7KYFQ+r1sooW3DAr8=;
        b=OlhKzBzFBXV3Ba+k5O8rr5To7hNgqb8sGdXf14fT4XmzOZss1sTk0IchY0CeComaoq
         bnrFDmFgMR1kscXqqc30T0PmlzgQdF4APKY0W1AgcCjL7EV59bTctGSE0qhrLuNQMM3l
         isVbPc9LdhuGVT6U/p521BplAcNbFyzzyKFIV3C9k39E1etecYJzKrMAAR2+VDXVid2M
         O4oO2UOyh3x39UNntTnFXRkVjdkXuKaOd2T4kAaN8rCX0TwW8qyBBD6CCoYlfx1CWf9o
         hJbLELYRAobKdPQyiLctKR+S3ldJdvTmVy69QjzmOVZFFuv7Touvn9OpKdZmFFhpgbLA
         eIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tct8NcMnuogShB9Wqv76Qs3Y6s7KYFQ+r1sooW3DAr8=;
        b=mARCJp+6PSuqcmdKHkvl+oNRFIos2AL0cIA28TSw7c3w4Kwbzs6zXKcAn+D/jN8WAf
         WO3XOHfxCYo+tnsomsYYAQ4/bdVkOJduMtQY3FVdtQyGMDysiJATswPNnd3mjdeAzUft
         K7ZoyOU3zFBj2BxiqUNy2PElrdjFiyoZtT3bMD09c08IvDzOuxwN3EQ/yp6K+DR5A2qI
         VMkiR3w3yqZBTFleUuibFE17Nej1CNs+JTTw9ayopLRhrKPEyTQNRivIEb7RdBEDrzny
         lxuO70xIsoQZegehw0pgV7KqYcT+ceZN5t+cc00Q+aMOgKQFGW2RuVbu+61XwBZm55W9
         d8Qw==
X-Gm-Message-State: APjAAAWqPqmN5xRKv+IGYJAHQwrrN1hO7Gz5VvLFDqjTLymAJWmNG/KW
        uCxrSdlRrtFDo6iY/UPSq0kb/pGU6+RdOKMowtacYg==
X-Google-Smtp-Source: APXvYqw9fTdEhDj8F/QTH3SVNsqiZvzaqHz+Qqv7WUBpDADV/DVg0Qu7n4ymIe0+Pg/6Rgd0YDN4b4qFw8qfMocI5Qc=
X-Received: by 2002:aca:55c2:: with SMTP id j185mr5464331oib.100.1562917027302;
 Fri, 12 Jul 2019 00:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAA7hF3zC2SrgC6JaKWzTDE6L6bP2o=zM_ZwdXgU7hwfJMraiCA@mail.gmail.com>
 <03c043d3-94e8-1865-b427-cc2a401bbd39@hartkopp.net> <CAA7hF3wReDrLcu5TtthO7NoxqK=uqzM-y6BtZJDjUVrPRz6bHg@mail.gmail.com>
 <1535589c-af2b-796d-b06a-88356be15e29@hartkopp.net>
In-Reply-To: <1535589c-af2b-796d-b06a-88356be15e29@hartkopp.net>
From:   laurent vaudoit <laurent.vaudoit@gmail.com>
Date:   Fri, 12 Jul 2019 09:36:55 +0200
Message-ID: <CAA7hF3whiRjupXTyfasAKuV1_BZWBSnuRxjXuFie7H5uBUqaFw@mail.gmail.com>
Subject: Re: BCM on ethernet link
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Thu, Jul 11, 2019 at 4:29 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi Laurent,
>
> On 11/07/2019 10.49, laurent vaudoit wrote:
>
> > Currently we use mainly TX periodical frames with update of frame when
> > needed (when a data change in our application)
> > and also RX stuffs, with rx timeout to be inform if a frame was not received.
>
> The reason for cyclic messages in cars is to detect failures on the
> transmission side (frames missing) or cover failures and restarts of the
> receiver side - e.g. due to undervoltage which might hit different ECUs
> in different manners.

we use it for some different purpose, but basically it is the same.
>
> As RDS provides a reliable transport the only missing function is to
> handle these startup and recovery situations. E.g. when the data sink
> reboots the content has to be pushed again.

yes it is the idea now.
thanks for your advice
>
> Regards,
> Oliver
Best Regards
Laurent
