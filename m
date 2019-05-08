Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA217DA3
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEHQAu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 12:00:50 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36142
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHQAu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 12:00:50 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764421; Wed, 08 May 2019 16:00:47 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V7 RESEND 04/10] can: mcp25xxfd: Add Microchip mcp25xxfd CAN FD driver
From:   kernel@martin.sperl.org
In-Reply-To: <9fe8a9bf-954e-e203-7b81-57b9460046fd@pengutronix.de>
Date:   Wed, 8 May 2019 18:00:58 +0200
Cc:     linux-can@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B58CC1B6-5D74-4C6B-AECC-6AEAC17037AC@martin.sperl.org>
References: <20190419051432.13538-1-kernel@martin.sperl.org> <20190419051432.13538-5-kernel@martin.sperl.org> <9fe8a9bf-954e-e203-7b81-57b9460046fd@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: Apple Mail (2.3124)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc!

> On 08.05.2019, at 15:12, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> static int mcp25xxfd_can_switch_mode_no_wait(struct mcp25xxfd_priv *priv,
>> 					     u32 *reg, int mode)
>> {
>> 	u32 dummy;
>> 	int ret;
>> 
>> 	/* get the current mode/register - if reg is NULL
>> 	 * when the can controller is not setup yet
>> 	 * typically by calling mcp25xxfd_can_sleep_mode
>> 	 * (this only happens during initialization phase)
>> 	 */
>> 	if (reg) {
>> 		if (!reg) {
> 
> This looks wrong.

should be:
>> 		if (!*reg) {

Fixed that - thanks!

Thanks,
	Martin 
