Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3561B140AAF
	for <lists+linux-can@lfdr.de>; Fri, 17 Jan 2020 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAQN1A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jan 2020 08:27:00 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38227 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQN1A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 08:27:00 -0500
Received: by mail-wm1-f43.google.com with SMTP id u2so7608028wmc.3
        for <linux-can@vger.kernel.org>; Fri, 17 Jan 2020 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VLz6jV1VTOxeJdG/AsJVNgjPCvJrDY/drsdDNe0Wet4=;
        b=HmveBNkJdbZN29zOQcqBHLkkV3HYIUE3eLA8KK6FO09ED0Xh99H8LBaRzzMgRMadKb
         HZKRyQuML4c1tu/7aqsv8xypaX/kJD4+aiKVrDfm4HZLvM/itKIVBhAyydh3u110/NVL
         z1tKmwpLcbDSGm8BOWT68VTdu1MWZC+XaqBzKk4LJ6189QuykH/0L3GF0V2EZSk6cNNG
         iv1bdeVnEFSvSW9XLnO1K07ZZ7rd2evifaTXEvxjftZFBBg3ahU40+XfsGP5qHLdZKQq
         W15hMBYUkGMKZtOZj6R9xQy9mfVnI2v0F007UBMCaCmeOhJj5n7IakK7T5eIGJF2IV64
         LHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VLz6jV1VTOxeJdG/AsJVNgjPCvJrDY/drsdDNe0Wet4=;
        b=CyS7lqoNFHjf32qoecJZZwXRp+kmCPonl453kydV5AeLwBPfJj5+ClQ1N6YGXCItnp
         7RDzxcB5t3D8ftwwG7ZRRzE4F5gUkVOeiwkAsxqRLYpPU7h2+0M4+dS4LZGo20KcNrPI
         1V3ShhCjaUR92Nv7wZnYtwO5sRONUAqhkaErcwVseUDtE3oeCb/fR90Gel+IIwoYmBJ9
         PJOqNqQJEUTX1QotKrMtd8OV1FIPcOv8/7wk0CNHIf9ALiqo04ulq40BvsRapceDbyJt
         gIS4GxuJbr7UiRqZIWuzcbS13H5+qzkj3Ype138F/Z+5abvlqBiB8SDIkO+yvTyJN3xx
         FKNw==
X-Gm-Message-State: APjAAAUJ0+7DX8CUCy28uIHaMoWOimXSmLrzM0j6lgknmK1fMaxMlWOq
        eigr06XeKNUwnv0XGEv+PpHlb0pK
X-Google-Smtp-Source: APXvYqyS6yypaR9z27tRE8jSdkXquwZ/qDrU7l/Z4+TH3O5stBnlRmPBZazoBIctHv42ArFSFkBIsQ==
X-Received: by 2002:a05:600c:1050:: with SMTP id 16mr4648345wmx.20.1579267619044;
        Fri, 17 Jan 2020 05:26:59 -0800 (PST)
Received: from ?IPv6:2a02:810d:1540:40aa:4118:28a8:49b0:1b37? ([2a02:810d:1540:40aa:4118:28a8:49b0:1b37])
        by smtp.gmail.com with ESMTPSA id s15sm31615174wrp.4.2020.01.17.05.26.58
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 05:26:58 -0800 (PST)
To:     linux-can@vger.kernel.org
From:   Andre Naujoks <nautsch2@gmail.com>
Subject: VCAN and CAN-FD DLC versus data length
Message-ID: <ec6ffa3c-b208-b76a-d1ac-afd2fb1182a7@gmail.com>
Date:   Fri, 17 Jan 2020 14:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all.

I just ran into some curious behaviour with the vcan driver in regards 
to CAN-FD and the DLC.

If I send a CAN-FD frame with a length, which is not directly 
representable by the DLC field, the vcan driver conserves this value. 
E.g. a Length of 11 is sent and received in userspace, even though there 
is no DLC representation for 11.

I talked to a colleague about this and we could not think of a case, in 
which this behaviour presents a problem. It is just a small discrepancy 
from how a real CAN would behave.

cansend from the can-utils package actually makes sure not to use a data 
length, which is not directly representable. This is the output of a 
candump oagainst a patched version, which does not "fix" the length.

$ candump any & ./patched-cansend vcan0 123##011223344556677889900AA
   vcan0  123  [11]  11 22 33 44 55 66 77 88 99 00 AA

Does anyone have a real case, which would warrant a patch to the vcan 
driver to change this? Or should the CAN stack even return EINVAL on a 
data length, that is not representable?

Regards
   Andre
