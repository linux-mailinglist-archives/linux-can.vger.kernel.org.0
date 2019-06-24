Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5645197E
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2019 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfFXR1B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jun 2019 13:27:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45440 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfFXR1A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jun 2019 13:27:00 -0400
Received: by mail-yw1-f67.google.com with SMTP id m16so6133390ywh.12
        for <linux-can@vger.kernel.org>; Mon, 24 Jun 2019 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXmuDDswJwasFysM5xAe3iWKG6lQgSipjb+VoaydZpo=;
        b=ZEzIcJAE76hfGZSdojtnNCDq8KnZa8QzLX4gcsB7N0ETY6ORcgQdkor67xpQexSWWo
         fnprlr44zWbGI7KMkoUFtAlcXBvv5h8VZTTFA5WYfT7tmNiBdpnUEvMjWV1eespYOnxk
         Fl+PI+e3gWgPAAA77uCNH9dQDpxVjW9vD+haq9JfuhF09FQJyTdun0ZPUHYjjtY0KurC
         v+0o1Wo/EOBSSgiNa8QwBP/x7zBnjsu9+huHIxK7XbalT0GWYGrUmiI2uEkTzkEN6Djk
         nC9qkPQYSsytaWz/1g2lwHRxrOvwJWFj6RibszIU/C+giXx6xQLf/9D3PHoZAG1pkMQh
         vRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXmuDDswJwasFysM5xAe3iWKG6lQgSipjb+VoaydZpo=;
        b=iNPWT9iu8F5g9mfT5So4J6lxx426xeXPmuyKDSbjQNsHv8wlZA4e/93nTOJusJju4C
         ltNly6F/JBW/ipQqVSv5A3Dme/WY7i1G233/YybeFPPu0WLH7pMPwDmgNbX3JAgGU93a
         4UoMZFC+jfKcSqA5Ju6N+QjFs0Sxk21g+IKf7V/TCTl+KUz4Fj/AWZ74KrhHaaCtt4yO
         hq0VJhf763lSYxxQkU1cUvwlbJJypEKjnK+uG90laoQVAAOg2CU57ICZCBfPPFF0AeaX
         Jr/Chz43MAQzqE0PVJZiZ9PD4aq38G1Z2epSka4PBkz54fs3+tVjzlULS7hssq5l8OHv
         Rw5Q==
X-Gm-Message-State: APjAAAUmEdVKkhGEF3Hyi8P39J9r5NzDgvsbGwjzlURaGnVqX/z/Op7C
        E5Pnc+SUQAKhk7D13HCJgY/CXLmn
X-Google-Smtp-Source: APXvYqzuJmKcjJNM3XSS6AuTLQRtCO9g97RJtQGrT5tl6YVRq6L8KL+JBdyjqyQCHbBgYQc8FRkccQ==
X-Received: by 2002:a81:22c1:: with SMTP id i184mr83830107ywi.292.1561397218518;
        Mon, 24 Jun 2019 10:26:58 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id a201sm3058731ywa.19.2019.06.24.10.26.56
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:26:56 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w9so1479918ybe.9
        for <linux-can@vger.kernel.org>; Mon, 24 Jun 2019 10:26:56 -0700 (PDT)
X-Received: by 2002:a25:21c2:: with SMTP id h185mr14071216ybh.125.1561397215686;
 Mon, 24 Jun 2019 10:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 24 Jun 2019 13:26:18 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
Message-ID: <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
Subject: Re: [PATCH net-next] can: dev: call netif_carrier_off() in register_candev()
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 24, 2019 at 4:34 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
> trigger as suggested, there's a small inconsistency with the link
> property: The LED is on initially, stays on when the device is brought
> up, and then turns off (as expected) when the device is brought down.
>
> Make sure the LED always reflects the state of the CAN device.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Should this target net? Regardless of CONFIG_CAN_LEDS deprecation,
this is already not initialized properly if that CONFIG is disabled
and a can_led_event call at device probe is a noop.
